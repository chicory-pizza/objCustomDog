// objCustomDog
// https://github.com/chicory-pizza/objCustomDog

using System;
using System.IO;
using System.Threading.Tasks;
using System.Linq;
using UndertaleModLib.Models;
using UndertaleModLib.Util;

EnsureDataLoaded();
if (Data?.GeneralInfo?.DisplayName?.Content != "Chicory_A_Colorful_Tale" || Data.IsYYC())
{
    throw new ScriptException("You need to use the Chicory Macaroni edition to use objCustomDog\n\nhttps://macaroni.chicory.pizza");
}

string[] importFiles = promptScriptsFolder();
if (importFiles == null)
{
    return;
}

SetProgressBar(null, "Summoning drawdogs...", 0, 1 + importFiles.Length);
StartProgressBarUpdater();

addObjCustomDog();
importGML(importFiles);

await StopProgressBarUpdater();
HideProgressBar();
ScriptMessage("objCustomDog is now added.");

// Main code logic
string[] promptScriptsFolder()
{
    ScriptMessage("Select the objCustomDog Scripts folder on the next folder dialog.");

    string importFolder = PromptChooseDirectory();
    if (importFolder == null)
    {
        return null;
    }

    string[] dirFiles = Directory.GetFiles(importFolder, "gml_Object_objCustomDog_*.gml");
    if (dirFiles.Length == 0)
    {
        throw new ScriptException("The selected folder doesn't contain any valid GML files.");
    }

    return dirFiles;
}

void addObjCustomDog()
{
    UndertaleGameObject customDog = Data.GameObjects.ByName("objCustomDog");

    if (customDog == null)
    {
        customDog = new UndertaleGameObject();
        Data.GameObjects.Add(customDog);
    }

    // Copying properties from objDog, basically
    customDog.Name = Data.Strings.MakeString("objCustomDog");
    customDog.Sprite = Data.Sprites.ByName("sprDog");
    customDog.ParentId = Data.GameObjects.ByName("objMob");
    customDog.CollisionShape = CollisionShapeFlags.Box;
    customDog.Awake = true;

    // Binding events are handled by ImportGMLFile()
}

async void importGML(string[] importFiles)
{
    // From ImportGML.csx
    SyncBinding("Strings, Code, CodeLocals, Scripts, GlobalInitScripts, GameObjects, Functions, Variables", true);
    await Task.Run(() =>
    {
        foreach (string file in importFiles)
        {
            IncrementProgress();

            ImportGMLFile(file, true, false, true);
        }
    });
    DisableAllSyncBindings();
}
