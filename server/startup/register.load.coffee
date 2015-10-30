Meteor.startup ->
  process.env.MAIL_URL="smtp://mist3st.zzz%40gmail.com:testaccount@smtp.gmail.com:465/";
  if Register.find().count() == 0
    register = [
      {
        'name': 'register 1'
      }
      {
        'name': 'register 2'
      }
    ]
    register.forEach (register) ->
      Register.insert register