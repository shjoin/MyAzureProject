""" This file handles email via mailx or smtp """
import smtplib, logging, subprocess, environment
from email.message import EmailMessage

def send_email_smtp(server : str, esubject : str, efrom : str, eto : str, emsg : str, eattach : str = ""):
    """
        Send an email via smtp
        SMTP is preferred over mailx for many reasons but you need access to the    
            SMTP server for it to work, mailx will work on any linux system
    """
    
    # Initialize a message
    msg = EmailMessage()

    # build a header
    msg["From"] = efrom
    msg["Subject"] = esubject
    msg["To"] = eto.split(";")
    msg.set_content(emsg)

    # If an attachment is included, add it
    if len(eattach) > 0:
        msg.add_attachment(open(eattach, "r").read(), filename=eattach)

    # Get the smtp info
    server = smtplib.SMTP(server)

    # Send the message
    server.send_message(msg)

    #Close the connection
    server.quit()
    # really need to add some exception handling and fallback code here

# eattach is required for a mailx email
def send_email_mailx(esubject : str, efrom : str, eto : str, emsg : str, eattach : str):
    """ send an email using mailx """

    # Build a nasty linux mailx command
    cmd=f"""echo "{emsg}" | cat - "{eattach}" | mailx -s '{esubject}' -r '{efrom}' {eto}"""
    #logging.debug(f"{cmd=}")

    # send the mail
    p=subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    # grab the stdout and stderr streams
    output, errors = p.communicate()
    #log any output, std or err
    logging.debug(f"mailx output: {esubject=} - {errors=} {output=}")    
    # really need to add some exception handling and fallback code here

# eattach is optional for an SMTP email
def send_email(esubject : str, efrom : str, eto : str, emsg : str, eattach : str = "", server : str = ""):
    """ sends an email to either smtp or mailx based on the env variable MAIL_METHOD """
   
    logging.debug(f"send_email: {environment.get_env_key('MAIL_METHOD')} ") 
    if environment.get_env_key("MAIL_METHOD") == "SMTP":
        # if server is not configured, cannot send via smtp
        if len(server) == 0:
            raise ValueError("Server is required to send an SMTP email. Server is empty in this call.")

        send_email_smtp(server = server, esubject = esubject, efrom = efrom, eto = eto, emsg = emsg, eattach = eattach)
    else:
        send_email_mailx(esubject = esubject, efrom = efrom, eto = eto, emsg = emsg, eattach = eattach)

    # really need to add some exception handling and fallback code here



