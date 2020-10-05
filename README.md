[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=aworldx_url_shortener&metric=alert_status)](https://sonarcloud.io/dashboard?id=aworldx_url_shortener)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=aworldx_url_shortener&metric=code_smells)](https://sonarcloud.io/dashboard?id=aworldx_url_shortener)
[![Duplicated Lines (%)](https://sonarcloud.io/api/project_badges/measure?project=aworldx_url_shortener&metric=duplicated_lines_density)](https://sonarcloud.io/dashboard?id=aworldx_url_shortener)
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=aworldx_url_shortener&metric=ncloc)](https://sonarcloud.io/dashboard?id=aworldx_url_shortener)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=aworldx_url_shortener&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=aworldx_url_shortener)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=aworldx_url_shortener&metric=reliability_rating)](https://sonarcloud.io/dashboard?id=aworldx_url_shortener)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=aworldx_url_shortener&metric=security_rating)](https://sonarcloud.io/dashboard?id=aworldx_url_shortener)
[![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=aworldx_url_shortener&metric=sqale_index)](https://sonarcloud.io/dashboard?id=aworldx_url_shortener)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=aworldx_url_shortener&metric=vulnerabilities)](https://sonarcloud.io/dashboard?id=aworldx_url_shortener)
# README

### Description
Test project for employment.
Formulation of the problem:  

Необходимо написать url shorterer.  
Необходимо реализовать сервис сокращения ссылок. Данный сервис должен реализовывать 3 запроса:

- POST /urls который возвращает короткий url  
- GET /urls/:short_url который возвращает длинный URL и увеличивает счетчик запросов на 1
- GET /urls/:short_url/stats который возвращает количество переходов по URL

Проект необходимо реализовать на Ruby On Rails.

### Run
- install docker
- RUN docker-compose build (for production)
- RUN migrations
- RUN docker-compose up (for production)

### Environment params description
- STORE_SERVICE - can take values db or redis. Defines where links will be stored.
- BASE_URL - base http address for compose a short link

### Run tests
- RUN docker-compose -f docker-compose.test.yml up

### WORKFLOW

- create new short url

request
```
curl --location --request POST 'http://127.0.0.1:3000/api/v1/urls?url=https://some-example-url.com'
```
response
```
{
    "success": true,
    "result": "http://shortener.com/9ee452fbb"
}
```

- get original url

request
```
curl --location --request GET 'http://127.0.0.1:3000/api/v1/urls/9ee452fbb'
```

response
```
{
    "success": true,
    "result": "http://some-example-url.com"
}
```

- clicks stat

request
```
curl --location --request GET 'http://127.0.0.1:3000/api/v1/urls/9ee452fbb/stats'
```

response

```
{
    "success": true,
    "result": 1
}
```

### Performance benchmark
env: 1 worker, 5 threads, db store, production mode
```
ab -k -c 5 -n 1000 http://127.0.0.1:3000/api/v1/urls/420d4e142

Concurrency Level:      5
Time taken for tests:   4.465 seconds
Complete requests:      1000
Failed requests:        0
Keep-Alive requests:    1000
Total transferred:      529000 bytes
HTML transferred:       56000 bytes
Requests per second:    223.99 [#/sec] (mean)
Time per request:       22.323 [ms] (mean)
Time per request:       4.465 [ms] (mean, across all concurrent requests)
Transfer rate:          115.71 [Kbytes/sec] received
```

env: 1 worker, 5 threads, redis store, production mode

```
ab -k -c 5 -n 1000 http://127.0.0.1:3000/api/v1/urls/5f67cff20

Concurrency Level:      5
Time taken for tests:   2.968 seconds
Complete requests:      1000
Failed requests:        0
Keep-Alive requests:    1000
Total transferred:      529000 bytes
HTML transferred:       56000 bytes
Requests per second:    336.93 [#/sec] (mean)
Time per request:       14.840 [ms] (mean)
Time per request:       2.968 [ms] (mean, across all concurrent requests)
Transfer rate:          174.06 [Kbytes/sec] received
```
### PS
Premature optimization is evil. This is all just for demonstration.
