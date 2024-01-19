# Create a Time Travelling Database
A presentation I gave at [SQL Saturday 840](https://www.sqlsaturday.com/840/eventhome.aspx) about creating a temporal database.  You can find the slides [here](Slides/SQL%20Saturday%20840.pdf) and an outline of the talk [here](Slides/Talk%20Outline.txt).

A lighting version of this talk can be found [here](https://github.com/saturdaymp-examples/a-brief-history-of-the-creation-of-a-time-traveling-database).  Finally more writting about temporal database can be found [here](https://nftb.saturdaymp.com/temporal-database-design/).

[![GitHub Sponsors](https://img.shields.io/github/sponsors/saturdaymp?label=Sponsors&logo=githubsponsors&labelColor=3C444C)](https://github.com/sponsors/saturdaymp)

# Quickstart
You'll need SQL Server installed to run the demos in the example [folder](Example).  If you have [Docker](https://www.docker.com/) installed there is a Docker Compose file to get you up and running quickly:

````
docker-compose up
````

You can then run the [Schema.sql](Schema.sql) script to create the database.  It has two temporal tables Customers and Addresses with triggers that enforce the temporal rules.  The [DemoQueries.sql](DemoQueries.sql) has some example data and queries to play with.

# Contributing
If you have any questions, notice a bug, or have a suggestion/enhancment please let me know by opening a [issue](https://github.com/saturdaymp-examples/create-a-time-travelling-database/issues) or [pull](https://github.com/saturdaymp-examples/create-a-time-travelling-database/pulls) request.

# Acknowledgements
Thanks to [Edmonton PASS](https://edmpass.pass.org/) and [SQL Saturday](https://www.sqlsaturday.com/) for inviting me to speak.
