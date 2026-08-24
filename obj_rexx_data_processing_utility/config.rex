/* Object REXX Data Processing Utility - Configuration Manager */

/* Initialize configuration */
initConfig: procedure expose config.
    
    -- Set default configuration values
    config.srcFile = 'input.csv'
    config.dstFile = 'output.csv'
    config.logLevel = 'INFO'
    config.reportDetail = 'NO'
    config.batchSize = 100
    
    return

/* Load configuration from file */
loadConfigFromFile: procedure expose config.
    arg configFile
    
    if fileExist(configFile) then do
        call stream configFile 'C' 'READ'
        
        do while lines(configFile) \= 0
            line = linein(configFile)
            
            -- Parse configuration line
            parse var line key '=' value
            
            -- Set configuration value
            if key \= '' then do
                config.key = value
            end
        end
        
        -- Close configuration file
        call stream configFile 'C' 'CLOSE'
    end
    
    return

/* Save configuration to file */
saveConfig: procedure expose config.
    arg configFile
    
    -- Open file for writing
    call stream configFile 'C' 'REPLACE'
    
    -- Write configuration values
    do i = 1 to config~attributes
        key = config~attribute(i)
        say key '=' config.key to .std
    end
    
    -- Close file
    call stream configFile 'C' 'CLOSE'
    
    return

/* Get configuration value */
getConfigValue: procedure expose config.
    arg key
    
    return config.key

/* Set configuration value */
setConfigValue: procedure expose config.
    arg key, value
    
    config.key = value
    return
