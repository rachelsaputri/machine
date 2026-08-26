/* reporter.cl */
/* Generates summary report of data processing */

PGM        PARM(&OUTDSM &ERRMSG)

DCL        VAR(&OUTDSM) TYPE(*CHAR) LEN(10)
DCL        VAR(&ERRMSG) TYPE(*CHAR) LEN(256)
DCL        VAR(&REPORTFILE) TYPE(*CHAR) LEN(10) VALUE('DSPLOUT')

/* Open report output */
OVRDBF     FILE(&REPORTFILE) TOFILE(QSYSOPR/QSQSPRT) MBR(*FIRST)

/* Write Summary Header */
WRITE      RCDLEN(256) FROM((&OUTDSM))

/* Write Status */
WRITE      RCDLEN(256) FROM((&ERRMSG))

/* Close report */
CLOSF      FILE(&REPORTFILE)

RETURN

ENDPGM
