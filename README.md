# README

## REST API

### Environment Variables

```
CLIENT_URL - the URI for the client app (localhost:3000 or some.domain.online)
ANALYTICS_SECRET - a secret key for creating a token to use the analytics api with - same key should be on analytics app
```


### Authentication

Every `User` and `StaffMember` record has `authentication_token`. We use that to authenticate users and staff members (including branch managers and admins).
To send the authentication token we use HTTP headers:

    Authorization: Token token=UT9D9JxUPzCyTd3n8RCw1w6A

where `UT9D9JxUPzCyTd3n8RCw1w6A` is an example `authentication_token`.

Once the `authentication_token` is correct we get `200` as HTTP response status, if not, then `401`.

    $ curl -v -X GET -H 'Authorization: Token token=UT9D9JxUPzCyTd3n8RCw1w6A' http://localhost:3000/api/v1/members

Authenticated user will be hereafter called `current_user`.

### Local setup

You will need ImageMagick in order to have the API working correctly, which can be installed using Homebrew:
`brew install imagemagick`

Then you can run the following commands to get the app setup initially:
`bundle install` (you may need `gem install bundler` if you've just installed the Ruby)
`bin/rails db:create:all`
`bin/rails db:migrate`
`bin/rails db:seed`

Verify everything is setup correctly by running the test suite:
`bundle exec rspec`

Setup slate so that the app can startup successfully:
`cd slate`
`bundle`

If you haven't already got it, you'll need Invoker to get the app up and running:

`bin/invoker start Procfile.dev` 

See http://invoker.codemancers.com/ for installation instructions if required.

### Seed data
`bin/rails db:seed`
`bin/rails db:seed:development`
`bin/rails db:seed:questions`

This will give you:

Partner admin: a@a.com / Password123
Partner branch manager: branch@manager.com / Password123
Vista admin: team@kanso.io / password

In order to see categories/questions in the Member apps, you will need to create a 'Release' in the admin:

admin.vista.test/releases -> create new release
This creates a JSON file to pass to member clients.

### GraphQL

The Partner/Kiosk app uses GraphQL to query the API.
You can test against the API using GraphQL, by using an app such as GraphiQL or GraphQL Playground.

Firstly, you'll need to authenticate with the API to retrieve a valid token to use in GraphQL requests:
```
POST api.vista.test/partners/v1/staff/login
{
  "email": "some@staffmember.com",
  "password": "password"
}
```

The returned token can then be set and used within GraphQL query headers:

`Authorization: Token token=returned-token-here`

### Push Notifications

In order to use push notifications in local development you will need to firstly create a certificate by following the steps shown in the following guide:

https://github.com/rpush/rpush/wiki/Generating-Certificates

Once you have a `.pem` file you will need to create an Rpush App by using Rails Console.

```
app = Rpush::App.new
app.name = "ios_app"
app.certificate = File.read("./certs/[vista-apns-dev.pem")
app.environment = "development" # APNs environment.
app.password = "certificate password"
app.connections = 1
app.save!
```

Once you log in via the `member-app` you should see an entry in the `devices` table.


