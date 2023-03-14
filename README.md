# Astro Job Creator

Astro Job Creator is a script for FiveM servers that allows server owners to create custom jobs easily. The script provides a simple command to create a job with a boss ID, name, and maximum grade limit, which automatically generates the job files and adds the job to QBcore.

The script also includes a boss menu that allows players with a boss job to change their job's stash and garage coordinates. The coordinates are saved to a JSON file on the server and can be retrieved using a TriggerCallback from the client.

![Boss Menu](https://media.discordapp.net/attachments/960497845402746890/1085211427721203822/image.png?width=248&height=88)

## Installation

- Download the script from GitHub.
- Add the script to your FiveM server's resources folder.
- Add `start astro-jobcreator` to your server.cfg file.

## Usage

To create a job, use the `/createjob` command in the server console or as an administrator in-game. The command takes three arguments:

- `bossId` - The ID of the boss job (the player ID who has access to the job menu).
- `jobName` - The name of the job.
- `gradesLimit` - The maximum number of grades for the job (up to four).

Once a job is created, it will automatically generate the job files and add the job to QBcore.

To access the job menu, use the `/ojp` command as a player with the boss job. From the job menu, players can change their job's stash and garage coordinates.

## Credits

- Astro - Script creator.
