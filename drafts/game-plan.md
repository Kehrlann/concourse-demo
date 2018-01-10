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
    - Create react app
    - Port TODO MVC
    - Create some tests
    - Create test+compile image
- Create back-end
    - Create kotlin backend
    - Create some tests
    - Create test+compile image
- Create e2e tests
    - Create image
    - Run wth Chrome headless
