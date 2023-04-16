# Django Experiment

This is a simple Django project to test the use of Django with a PostgreSQL database.

Somewhat following the two-scoops book, somewhat following patterns I've already seen, and experimenting with largely pairing with copilot and ChatGPT to build it all.

## Setup

A few make commands will get you on your way:

1. `make develop` spins up a container that can act as a kind of virtual environment
2. `make makemigrations` will create the migrations for the database
3. `make migrate` will apply the migrations to the database
4. `make start` will start the Django server
5. `make help` to see other bits