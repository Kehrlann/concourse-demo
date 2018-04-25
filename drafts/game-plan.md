# Concourse, l'intégration Cloud-Native

## Présentation Générale
### Historique
### Qui utilise Concourse

## Détails de fonctionnement
### Concepts
- Resources
- Jobs (with tasks)
- Pipeline
### Immutable UI
### CLI tool : `fly`

## Action !
- Ping : show the basic pipleine
  - set-it
  - watch it work
- Ping : send the task
- Ping : send the task with input and output
  - before : tree the demo directory
  - show input
  - run it
  - show ouptut.log
- QUESTIONS !!

- Show the app
- Show tests on the backend, on the front-end
- Show end-to-end tests

- Add backend
  - explain resource
- Curl http://todo.ci.local.pcfdev.io/todo

- Add front-end
  - Show config reuse
  - Show todo.ci.local.pcfdev.io

- Add e2e
  - Explain passed

- Add package
  - Explain that this is for a single team doing both, and integrating
  - Explain that this gives reproducible deploys
  - Explain that you could have an extra step
  - Show todo.local.pcfdev.io

- Talk about microservices and decoupled things
  - Show decoupled pipeline : pronounce "fan-out"
  - Change the front-end title
  - Watch it propagate

# Before the talk
- ssh start
- cf dev resume
- docker-compose up
- presentation up
- frontend up
- backend up
- check concourse IP = 172.19.0.3
- remove ~/tmp/concourse/out/output.log
- Make sure git repo is clean
- empty buckets
- delete apps
- -> Check spaces ci and prod, as well as domain ci.apps.local.pcfdev.io
- Rebuild docker images for front-end, backend, and e2e
