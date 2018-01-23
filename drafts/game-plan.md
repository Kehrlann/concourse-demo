# Concourse, l'intégration Cloud-Native

## Présentation Générale
### Historique
### "vs"
Why are we even building something new
### Qui utilise Concourse

## Détails de fonctionnement
### Concepts
- Resources
- Jobs (with tasks)
- Pipeline
### Immutable UI
### CLI tool : `fly`

## Action !
- Git resource
- get + test (e.g. backend)
- refactor : put the task in it's own file, same for the script
- Fly : hijack, execute
- Duplicate : front-end (c-c + c-v this one)
- Swap out vanilla docker image for custom ones
- Deploy to s3 + pcf
- Integrate (integration testing)
- Publish on tag (package)
- Push


## TODO before action can happen :
- Create front-end
    x Create react app
    x Port TODO MVC
    x Create some tests
      x Add SinonJS for mocking
      x Add enzyme for testing
      x Don't forget to get Sinon docs
    x Add proxy to backend for local dev
    x Create test+compile image
- Create back-end
    x Create kotlin backend
    x Fix rest repository path 
    x Create some tests
    x Create test+compile image
- Create e2e tests
    x Run wth locally with Testcaffe
    - Create image
    - Run e2e tests from previous jobs
      - Install minio docker image for putting the artifacts ?
- Publish on tag
    - Add the publish stage
    - Add the deploy stage
- Deploy to CF
    - Start up PCF-dev
    - Stand up a MySQL db ??
