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
alias Overstats.Overwatch.{Hero, Map}
alias Overstats.Players.Player

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
Repo.insert(%Hero{name: "Kiriko", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Lúcio", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Mercy", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Moira", role: "Support"} |> Hero.changeset(%{}))
Repo.insert(%Hero{name: "Zenyatta", role: "Support"} |> Hero.changeset(%{}))

# Insert all maps and their mode
# Information & Images credit to: https://overwatch.fandom.com/wiki/Maps

Repo.insert(
  %Map{
    name: "Circuit Royal",
    type: "Escort",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/1/10/Monte_Carlo.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Dorado",
    type: "Escort",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/e/ec/Dorado-streets2.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Havana",
    type: "Escort",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/9/93/Havana.png"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Junkertown",
    type: "Escort",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/e/e3/Junkertown.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Rialto",
    type: "Escort",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/f/ff/Rialto.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Route 66",
    type: "Escort",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/a/a6/Route_66.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Shambali Monastery",
    type: "Escort",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/8/81/ShambaliEscort.png"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Watchpoint: Gibraltar",
    type: "Escort",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/8/8b/Gibraltar.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Blizzard World",
    type: "Hybrid",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/f/f8/Blizzard_World.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Eichenwalde",
    type: "Hybrid",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/a/aa/Eichenwalde.png"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Hollywood",
    type: "Hybrid",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/2/26/Hollywood-set.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "King's Row",
    type: "Hybrid",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/1/1b/King%27s_Row_concept.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Midtown",
    type: "Hybrid",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/4/4e/N18S6DCTDPG81613669123002.png"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Numbani",
    type: "Hybrid",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/1/1b/Numbani_Loading_Screen.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Paraíso",
    type: "Hybrid",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/9/90/Para%C3%ADso_pvp.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Busan",
    type: "Control",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/0/09/Overwatch_Busan.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Ilios",
    type: "Control",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/4/45/Ilios.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Lijiang Tower",
    type: "Control",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/9/9b/Lijiang_Tower_loading_screen.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Nepal",
    type: "Control",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/f/f3/Nepal_loading_screen.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Oasis",
    type: "Control",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/f/fc/Oasis.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Colosseo",
    type: "Push",
    img_url:
      "https://static.wikia.nocookie.net/overwatch_gamepedia/images/1/1e/Blizzconline_rome_01.png"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "Esperança",
    type: "Push",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/f/f5/PortugalPush.jpg"
  }
  |> Map.changeset(%{})
)

Repo.insert(
  %Map{
    name: "New Queen Street",
    type: "Push",
    img_url: "https://static.wikia.nocookie.net/overwatch_gamepedia/images/9/91/Toronto.jpg"
  }
  |> Map.changeset(%{})
)

# Insert unique player for randomly-matched players
Repo.insert(%Player{name: "Random"} |> Player.changeset(%{}))
