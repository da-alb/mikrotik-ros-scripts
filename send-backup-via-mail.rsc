# Set variables  
:local hostname [/system identity get name];  
:local filename ($hostname . "-backup.rsc");  
:local emailTo "<email>";
:local emailSubject ("MikroTik Configuration Export - " . [/system identity get name]);
:local emailBody ("The configuration for MirkoTik router/switch" . [/system identity get name]);

# Logging the start of the script
:log info "Starting configuration export..." 

# Export the configuration
/export show-sensitive file=$filename

:delay 10s; #adjust if needed

# Check if export file exists
:if ([/file find name=$filename] != "") do={
    :log info "Export file found. Proceeding with email."

    # Email sending block with detailed logging
    :log info "About to send email...";
    :local emailResult [/tool e-mail send to=$emailTo subject=$emailSubject body=$emailBody file=$filename];
    :log info ("Email command result: " . $emailResult);
}

:log info "Finished Configuration Export Script"; # Log end of script
