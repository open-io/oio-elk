{
  "actions": {
    "Email test": {
      "throttle_period": "0h15m0s",
      "email": {
        "to": "pi.badiane@gmail.com",
        "from": "pacobadiane17@gmail.com",
        "subject": "subject",
        "priority": "high",
        "body": "Found {{payload.hits.total}} Events",
        "save_payload": false
      }
    },
    "New console action zkctj3ltjks": {
      "throttle_period": "0h0m1s",
      "console": {
        "message": ""
      }
    },
    "New slack action 6d2cmux7ti": {
      "throttle_period": "0h0m1s",
      "slack": {
        "channel": "#elk-alerting",
        "message": "hello",
        "stateless": false
      }
    }
  },
  "input": {
    "search": {
      "request": {
        "index": [
          "oio-*"
        ],
        "body": {}
      }
    }
  },
  "condition": {
    "script": {
      "script": "payload.hits.total > 1"
    }
  },
  "transform": {},
  "trigger": {
    "schedule": {
      "later": "every 5 minutes"
    }
  },
  "disable": false,
  "report": false,
  "title": "watcher_title"
}
