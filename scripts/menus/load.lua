function RunLoadGameMenu()
  local menu = WarMenu(nil, hpanel3, false)
  menu:setSize(384, 256)
  menu:setPosition((Video.Width - 384) / 2, (Video.Height - 256) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Load Game", 384 / 2, 11)
  local browser = menu:addBrowser("~save", "^.*%.sav%.?g?z?$",
    (384 - 300 - 18) / 2, 11 + (36 * 1.5), 318, 126)

  function startgamebutton(s)
    print("Starting saved game")
    currentCampaign = nil
    loop = true
    while (loop) do
      StartSavedGame("~save/" .. browser:getSelectedItem())
      if (GameResult ~= GameRestart) then
        loop = false
      end
    end
    RunResultsMenu()
    if currentCampaign ~= nil then
      if GameResult == GameVictory then
        position = position + 1
      elseif GameResult == GameDefeat then
        position = position
      else
        currentCampaign = nil
        return
      end
      RunCampaign(currentCampaign)
    end
    menu:stop()
  end

  menu:addHalfButton("~!Load", "l", (384 - 300 - 18) / 2, 256 - 16 - 27, startgamebutton)
  menu:addHalfButton("~!Cancel", "c", 384 - ((384 - 300 - 18) / 2) - 106, 256 - 16 - 27,
    function() menu:stop() end)

  menu:run()
end
