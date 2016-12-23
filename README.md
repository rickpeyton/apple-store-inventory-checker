# Apple AirPods Inventory Check

I want to know when I can walk into an Apple Store and buy some AirPods. This
script will text me when I can.

## Warning

This is a pretty specialized script. The store IDs are in the result set for my
zip code. If you want to use this script you are going to need to modify the
store ids to only include the stores you want to check.

I set this script up on a cron job. The downside is that it will keep on pinging
me until I turn it off.

I am using a Twilio trial account to send the SMS messages.

## Getting going

```
git clone git@github.com:rickpeyton/apple-airpods-inventory-check.git
cd apple-airpods-inventory-check
bundle
touch .env
```

And fill in the .env

```
vim .env
```

```
TWILIO_SID=...
TWILIO_AUTH=...
TWILIO_NUMBER=...
MY_NUMBER=...
```

```
ruby run.rb
```

You will either receive a text or find a result in `log`
