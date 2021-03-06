/*
 * Jakefile
 * CappuccinoIssue725
 *
 * Created by You on June 16, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

var ENV = require("system").env,
    FILE = require("file"),
    JAKE = require("jake"),
    task = JAKE.task,
    FileList = JAKE.FileList,
    app = require("cappuccino/jake").app,
    configuration = ENV["CONFIG"] || ENV["CONFIGURATION"] || ENV["c"] || "Debug",
    OS = require("os");

app ("CappuccinoIssue725", function(task)
{
    task.setBuildIntermediatesPath(FILE.join("Build", "CappuccinoIssue725.build", configuration));
    task.setBuildPath(FILE.join("Build", configuration));

    task.setProductName("CappuccinoIssue725");
    task.setIdentifier("com.yourcompany.CappuccinoIssue725");
    task.setVersion("1.0");
    task.setAuthor("Your Company");
    task.setEmail("feedback @nospam@ yourcompany.com");
    task.setSummary("CappuccinoIssue725");
    task.setSources((new FileList("**/*.j")).exclude(FILE.join("Build", "**")));
    task.setResources(new FileList("Resources/**"));
    task.setIndexFilePath("index.html");
    task.setInfoPlistPath("Info.plist");

    if (configuration === "Debug")
        task.setCompilerFlags("-DDEBUG -g");
    else
        task.setCompilerFlags("-O");
});

task ("default", ["CappuccinoIssue725"], function()
{
    printResults(configuration);
});

task ("build", ["default"]);

task ("debug", function()
{
    ENV["CONFIGURATION"] = "Debug";
    JAKE.subjake(["."], "build", ENV);
});

task ("release", function()
{
    ENV["CONFIGURATION"] = "Release";
    JAKE.subjake(["."], "build", ENV);
});

task ("run", ["debug"], function()
{
    OS.system(["open", FILE.join("Build", "Debug", "CappuccinoIssue725", "index.html")]);
});

task ("run-release", ["release"], function()
{
    OS.system(["open", FILE.join("Build", "Release", "CappuccinoIssue725", "index.html")]);
});

task ("deploy", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Deployment", "CappuccinoIssue725"));
    OS.system(["press", "-f", FILE.join("Build", "Release", "CappuccinoIssue725"), FILE.join("Build", "Deployment", "CappuccinoIssue725")]);
    printResults("Deployment")
});

task ("desktop", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Desktop", "CappuccinoIssue725"));
    require("cappuccino/nativehost").buildNativeHost(FILE.join("Build", "Release", "CappuccinoIssue725"), FILE.join("Build", "Desktop", "CappuccinoIssue725", "CappuccinoIssue725.app"));
    printResults("Desktop")
});

task ("run-desktop", ["desktop"], function()
{
    OS.system([FILE.join("Build", "Desktop", "CappuccinoIssue725", "CappuccinoIssue725.app", "Contents", "MacOS", "NativeHost"), "-i"]);
});

function printResults(configuration)
{
    print("----------------------------");
    print(configuration+" app built at path: "+FILE.join("Build", configuration, "CappuccinoIssue725"));
    print("----------------------------");
}
