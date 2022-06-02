function addQuests()
    quest_line_def = {
        text = "Ultra Items Quests",
    }

    quest_def = {
        id = "my_new_quest",
        title = "My New Quest",
        reqs = {"planks1@10"},
        icon = "planks1",
        reward = "axe2@1",
        unlock = {},
        unlocked = true
    }

    quest_page1 = {
        { text = "Hello this is my quest" },
        { text = "This line is BLUE", color = "FONT_BLUE" }
    }
    quest_page2 = {
        { text = "This is cool have a free reward" },
    }

    api_define_quest(quest_def, quest_page1, quest_page2)
end