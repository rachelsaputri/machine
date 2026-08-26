/* main.cl */
/* Entry point for the CL Compliance Data Processor */

PGM        PARM(&INPDSM &OUTDSM &ERRMSG)

DCL        VAR(&INPDSM) TYPE(*CHAR) LEN(10)
DCL        VAR(&OUTDSM) TYPE(*CHAR) LEN(10)
DCL        VAR(&ERRMSG) TYPE(*CHAR) LEN(256)

/* Initialize error message */
CHGVAR     VAR(&ERRMSG) VALUE('Initialization complete.')

/* Call Parser */
CALL       PGM(parser) PARM(&INPDSM)

/* Call Validator */
CALL       PGM(validator) PARM(&INPDSM &ERRMSG)

/* If no errors, proceed to Process */
IF         COND(&ERRMSG *EQ 'Initialization complete.') THEN(DO)
    CALL       PGM(processor) PARM(&INPDSM &OUTDSM &ERRMSG)
ENDDO

/* Call Reporter regardless of error state to log final status */
CALL       PGM(reporter) PARM(&OUTDSM &ERRMSG)

/* End Program */
RETURN

ENDPGM
