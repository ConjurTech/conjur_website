require 'slack-notifier'

class WelcomeController < ApplicationController
  def show
  end

  def index
  end

  def contact
    unless [:name, :email, :message].all? {|s| params[s].present? }
      return render json: { error: 'Please fill up all fields.' }, status: :unprocessable_entity
    end

    return render json: { error: 'No slack endpoint set!' }, status: :unprocessable_entity unless ENV['SLACK_WEBHOOK_URL']

    notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'],
                                   channel: '#general',
                                   username: 'contact-bot')

    msg = notifier.escape(params[:message])
    name = notifier.escape(params[:name])
    email = notifier.escape(params[:email])
    href = mail_to(params[:email],
                   subject: 'Hello from Conjur!',
                   cc: 'tech@conjur.tech',
                   body: "Hi there,\n\nWe've received your message and..\n\n\n\nRegards,\n\nConjur Technologies\n\n\n\n---\n\nOriginal Message:\n\n#{msg}"
    )

    payload = {
        fallback: format("New message from #{name} (#{email}) received - #{msg}"),
        pretext: "*Message Details*",
        color: "#9ad3de",
        fields: [
            {
                title: 'Name',
                value: name,
                short: true
            },
            {
                title: 'Email',
                value: format("[#{email}](#{href})"),
                short: true
            },
            {
                title: 'Message',
                value: msg,
                short: false
            },
            {
                value: format("[Reply to #{name}](#{href})"),
                short: false
            }
        ],
        mrkdwn_in: ["pretext", "fields"] # fields doesn't work, have to use format method still
    }

    notifier.ping format('<!channel>: Great News! New lead received through [conjur.tech](http://conjur.tech):'), attachments: [payload]

    render json: { message: 'ok' }
  end

  private

  def format(msg)
    Slack::Notifier::LinkFormatter.format(msg)
  end

  def mail_to(email_address, options = {})
    options = options.stringify_keys
    extras = %w{ cc bcc body subject }.map! { |item|
      option = options.delete(item) || next
      "#{item}=#{Rack::Utils.escape_path(option)}"
    }.compact
    extras = extras.empty? ? '' : '?' + extras.join('&')

    "mailto:#{email_address}#{extras}"
  end
end
