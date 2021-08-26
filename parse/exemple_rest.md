#Some example to use with curl

## getting all position nearest the given point
curl -X GET \
  -H "X-Parse-Application-Id: myAPP" \
  -H "X-Parse-REST-API-Key: undefined" \
  -G \
  --data-urlencode 'limit=1' \
  --data-urlencode 'where={
        "geo": {
          "$nearSphere": {
            "__type": "GeoPoint",
            "latitude": 30.0,
            "longitude": -20.0
          }
        }
      }' \
  http://144.126.218.1:1337/parse/classes/test

## call a cloud function
curl -X POST \
  -H "X-Parse-Application-Id: myAPP" \
  -H "X-Parse-REST-API-Key: myRestKey" \
  -H "Content-Type: application/json" \
  -d '{}' \
  https://144.126.218.1:133/parse/functions/hello
