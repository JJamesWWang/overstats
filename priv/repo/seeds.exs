# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Overstats.Repo.insert!(%Overstats.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Overstats.Repo
alias Overstats.Overwatch.Hero
alias Overstats.Overwatch.Map


# Insert all heroes and their role
# https://overwatch.fandom.com/wiki/Heroes

Repo.insert(%Hero{name: "D.Va", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Doomfist", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Junker Queen", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Orisa", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Ramattra", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Reinhardt", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Roadhog", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Sigma", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Winston", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Wrecking Ball", role: "Tank"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Zarya", role: "Tank"} |> Hero.changeset(%{}))

Repo.insert(%Hero{name: "Ashe", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Bastion", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Cassidy", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Echo", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Genji", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Hanzo", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Junkrat", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Mei", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Pharah", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Reaper", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Soldier: 76", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Sojourn", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Sombra", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Symmetra", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Torbjörn", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Tracer", role: "Damage"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Widowmaker", role: "Damage"} |> Hero.changeset(%{}))

Repo.insert(%Hero{name: "Ana", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Baptiste", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Brigitte", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Lúcio", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Mercy", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Moira", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Zenyatta", role: "Support"} |> Hero.changeset(%{}))


# Insert all maps and their mode
# https://overwatch.fandom.com/wiki/Maps

Repo.insert(%Map{name: "Circuit Royal", type: "Escort"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Dorado", type: "Escort"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Havana", type: "Escort"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Junkertown", type: "Escort"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Rialto", type: "Escort"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Route 66", type: "Escort"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Shambali Monastery", type: "Escort"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Watchpoint: Gibraltar", type: "Escort"} |> Map.changeset(%{}))

Repo.insert(%Map{name: "Blizzard World", type: "Hybrid"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Eichenwalde", type: "Hybrid"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Hollywood", type: "Hybrid"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "King's Row", type: "Hybrid"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Midtown", type: "Hybrid"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Numbani", type: "Hybrid"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Paraíso", type: "Hybrid"} |> Map.changeset(%{}))

Repo.insert(%Map{name: "Busan", type: "Control"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Ilios", type: "Control"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Lijiang Tower", type: "Control"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Nepal", type: "Control"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Oasis", type: "Control"} |> Map.changeset(%{}))

Repo.insert(%Map{name: "Colosseo", type: "Push"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "Esperança", type: "Push"} |> Map.changeset(%{}))
Repo.insert(%Map{name: "New Queen Street", type: "Push"} |> Map.changeset(%{}))
