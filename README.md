# README

Remembrall is a vault for storing links. It was built for Slack, so it will capture
and save all urls shared in the channels where you configured the hook.

It is composed by two parts:

* API: the messages are posted by slack to a `/message` route. It can also be
  used by third-part systems as long as they respect the contract of the json
  (basically, the links in the text must be wrapped around `<>`)

* Dashboard: by accessing the `/` route, you can visualize the saved urls and
  search the database.

Once Remebrall is up and running, all links shared in the chosen channels will
automatically be saved. To know how to configure channels read the section
*Configuring the hook* below.

A tip: duplicated links are never saved again!

## Important info

* Ruby Version: 2.3.0
* Database: postgres (tested with version 9.4.5)
* To run the test suite: `bin/rspec`

In development, copy the `.env.example` to a file named `.env` and add your slack
token in it. You can generate a token [here](https://api.slack.com/docs/oauth-test-tokens).

The database is configured in the config/database.yml file, and can also be
modified with environment variables. Add any of these keys to your .env if
you do not want to run with the default database settings:

* POSTGRESQL_USER
* POSTGRESQL_DATABASE
* POSTGRESQL_PASSWORD
* POSTGRESQL_HOST
* POSTGRESQL_POOL
* POSTGRESQL_PORT

For testing purposes, there is a seed to populate the first articles in the
database. To populate it, just go to the console and run:

```
  bin/rake db:seed
```

Of course, it expects you to have already run `bin/rake db:create db:migrate` :)

## Users

To fetch Slack users and save their ids and avatars you need to go to the
console and run:

```
bin/rake import_slack_users
```

It will use the SLACK_TOKEN on the `.env` file and retrieve the information. You
can run this command as many times as you need, the data is never destroyed. This
is good because you can run it from times to times to ensure the avatars are
in sync with slack.

## Configuring the hook

Time to make it work. All you need to do is to go to your slack integrations page
(https://<SLACK NAME>.slack.com/apps/manage/custom-integrations), choose
`Outgoing Webhooks` and `Add Configuration`.

Give it a name, choose a channel and fill the `URL(s)` field with this project
url (it must be opened to the internet, `localhost` will not work because slack needs
to communicate with that url) pointing to `/message`. Now, every time someone posts
a message in the chosen channel Slack will post a json to us, that will be parsed
in order to extract the urls.

You can repeat this configuration on as many channels as you want - but be aware
that each channel will require a new Outgoing Webhook configuration.


## The black list

There might be a list of urls you don't want to save. For example, there is no
need to store hangouts' conversations or links to Remembrall itself. To prevent
a link to be saved, include part of it in the `BLACK_LIST` constant inside the
`models/url.rb`.


## The name

The name is a homage to the Harry Potter Remembrall, a magical artifact created to
remind its bearer that he/she has forgotten something. The idea behind this is
that we kept forgetting the links we shared on slack, so now we can store
them automatically, without having to take any special action. Once the link is
shared, anyone can find it back easily.
