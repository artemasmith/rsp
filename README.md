# README

## The deploy
It doesn't use DB, so deploy is quite easy. You can just run 'rails s' in the console and visit localhost:3000

## Details
The API client uses Net::HTTP, because we don't use retryes or any complicated way of data retrieving.
GameService can use different RuleEngines to run. A RuleEngine should have 2 methods: parse and possible_throws.
Rules format: "scissors->paper;paper->rock;rock->scissors", where each rule is separated with ';' and
arrow '->' define whic element win.

The rules, url to the Curb API server are set in the ENV variables or in config/srp_setting.yml (check it before change)

P.S. css is poor.