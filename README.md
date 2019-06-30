# How to reproduce the error

1. Start the application through `docker-compose up` (having Docker and docker-compose installed)
2. Access the container by executing `docker exec -it capybara_screenshot_example sh`
3. Run `bundle exec derailed bundle:mem` multiple times. Sometimes it might come up after 5-8 runs, sometimes on the first.
