
module main

import system, io, text

export main

import configParser
import policyEngine
import reporter

var logFile : string := "audit_log.txt"
var configDir : string := "configs/"
var policyDir : string := "policies/"
var reportFile : string := "compliance_report.txt"

procedure main
    var cfg : list of string := system.commandLineArguments()
    if cfg.count < 3 then
        system.print("Usage: turing_compliance_auditor <config_dir> <policy_dir> <report_file>")
        exit
    end if
    configDir := cfg[1]
    policyDir := cfg[2]
    reportFile := cfg[3]
    
    system.print("Initializing Compliance Auditor...")
    var configData : list of record
        var name : string
        var value : string
        var criticality : int
    end record := readConfigFiles(configDir)
    
    var policies : list of record
        var ruleName : string
        var condition : string
        var requiredValue : string
        var action : string
    end record := loadPolicies(policyDir)
    
    var results : list of record
        var configName : string
        var status : string
        var details : string
    end record
    
    for i := 0 to configData.count-1 by 1 do
        var c := configData[i]
        var compliant := true
        var detailsList : list of string
        for j := 0 to policies.count-1 by 1 do
            var p := policies[j]
            var match := evaluateCondition(c.name, c.value, p.condition, p.requiredValue)
            if match = false then
                compliant := false
                detailsList.add(p.ruleName + " failed: expected '" + p.requiredValue + "', got '" + c.value + "'")
            end if
        end for
        var statusStr : string := "PASS"
        if compliant = false then
            statusStr := "FAIL"
        end if
        var detailStr : string := ""
        for k := 0 to detailsList.count-1 by 1 do
            if detailStr.length > 0 then
                detailStr := detailStr + "; " + detailsList[k]
            else
                detailStr := detailsList[k]
            end if
        end for
        results.add(record(c.name, statusStr, detailStr))
    end for
    
    writeReport(results, reportFile)
    system.print("Audit complete. Report saved to " + reportFile)
end main

function evaluateCondition(name : string, value : string, condition : string, requiredValue : string) : bool
    var condParts : list of string := condition.split(" ")
    var op : string := condParts[0]
    var field : string := condParts[1]
    if field != name then
        return true
    end if
    if op = "equals" then
        return value = requiredValue
    elsif op = "contains" then
        return value.contains(requiredValue)
    elsif op = "regex" then
        return value.match(".*" + requiredValue + ".*")
    end if
    return true
end evaluateCondition

function readConfigFiles(dir : string) : list of record
    var files : list of string := system.listFiles(dir)
    var data : list of record
        var name : string
        var value : string
        var criticality : int
    end record
    for i := 0 to files.count-1 by 1 do
        var fname := files[i]
        if fname.endsWith(".cfg") then
            var f := io.openRead(dir + fname)
            if f not= nil then
                var line : string
                while f.readLine(line) = io.OK do
                    var parts : list of string := line.split("=")
                    if parts.count = 2 then
                        data.add(record(parts[0], parts[1], 1))
                    end if
                end while
                f.close
            end if
        end if
    end for
    return data
end readConfigFiles

function loadPolicies(dir : string) : list of record
    var files : list of string := system.listFiles(dir)
    var pols : list of record
        var ruleName : string
        var condition : string
        var requiredValue : string
        var action : string
    end record
    for i := 0 to files.count-1 by 1 do
        var fname := files[i]
        if fname.endsWith(".pol") then
            var f := io.openRead(dir + fname)
            if f not= nil then
                var line : string
                var curPol : record
                while f.readLine(line) = io.OK do
                    line := line.trim
                    if line.startsWith("rule") then
                        if curPol.ruleName not= "" then
                            pols.add(curPol)
                        end if
                        var parts := line.split(" ")
                        curPol.ruleName := parts[1]
                        curPol.condition := ""
                        curPol.requiredValue := ""
                        curPol.action := ""
                    elsif line.startsWith("condition") then
                        curPol.condition := line.split(":", 1)[1].trim
                    elsif line.startsWith("value") then
                        curPol.requiredValue := line.split(":", 1)[1].trim
                    elsif line.startsWith("action") then
                        curPol.action := line.split(":", 1)[1].trim
                    end if
                end while
                if curPol.ruleName not= "" then
                    pols.add(curPol)
                end if
                f.close
            end if
        end if
    end for
    return pols
end loadPolicies

procedure writeReport(results : list of record, fileName : string)
    var f := io.openWrite(fileName)
    if f not= nil then
        f.writeLine("COMPLIANCE AUDIT REPORT")
        f.writeLine("=====================")
        f.writeLine("Total Checks: " + results.count)
        var passed := 0
        var failed := 0
        for i := 0 to results.count-1 by 1 do
            f.writeLine("- " + results[i].configName + ": " + results[i].status)
            f.writeLine("  Details: " + results[i].details)
            if results[i].status = "PASS" then
                passed += 1
            else
                failed += 1
            end if
        end for
        f.writeLine("Summary: " + passed + " Passed, " + failed + " Failed")
        f.close
    end if
end writeReport
