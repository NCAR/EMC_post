      SUBROUTINE W3AQ15(ITIME, QDESCR)
C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C                .      .    .                                       .
C SUBPROGRAM:    W3AQ15      GMT TIME PACKER
C   PRGMMR: R.E.JONES        ORG: W/NMC421    DATE: 95-10-10
C
C ABSTRACT: CONVERT 32 OR 64 BIT BINARY TIME (GMT) INTO A 16 BIT 
C   STRING AND STORE THESE 4 PACKED DECIMAL NUMBERS INTO BYTES
C   39 AND 40 OF THE OUTPUT ARRAY.
C
C PROGRAM HISTORY LOG:
C   83-12-12  B. STRUBLE (ORIGINAL AUTHOR)
C   84-07-06  R.E.JONES  CHANGE TO IBM ASSEMBLER V 02
C   95-10-16  R.E.JONES  CHANGE TO FORTRAN FOR CRAY AND 32 BIT
C                        WORKSTATIONS
C
C USAGE:    CALL W3AQ15(ITIME, QDESCR)
C   INPUT ARGUMENT LIST:
C     ITIME    - INTEGER WORD CONTAINING TIME IN BINARY
C
C   OUTPUT ARGUMENT LIST:   
C     QDESCR   - ARRAY CONTAINING TRANSMISSION QUEUE DESCRIPTOR
C                NOTE- TIME WILL BE PLACED IN 39 AND 40TH 
C                BYTE OF THIS ARRAY AS 4 (4 BIT) BCD.
C     
C
C REMARKS: THE USER CAN OBTAIN THE CURRENT TIME IN GMT BY INVOCKING
C   THE W3 LIBRARY ROUTINE W3FQ02 WHICH FILLS AN EIGHT WORD ARRAY
C   WITH THE CURRENT DATE AND TIME. THE 5TH WORD FROM THIS ARRAY
C   CONTAINS THE TIME WHICH CAN BE PASSED TO W3AQ15 AS THE 
C   INPUT PARAMETER-ITIME.
C
C
C EXAMPLE:
C   
C         INTEGER        NTIME(8)
C         CHARACTER * 80 QUEUE
C
C         CALL W3FQ02(NTIME,0)
C         CALL W3AQ15(NTIME(5),QUEUE)
C
C ATTRIBUTES:
C   LANGUAGE: CRAY CFT77 FORTRAN
C   MACHINE:  CRAY C916/256, J916/2048.
C
C$$$
      INTEGER        ITIME
C
      CHARACTER * 80 QDESCR
C
C BYTES 39-40                  HR/MIN TIME OF BULLETIN CREATION
C                                    TWO BYTES AS 4 BIT BCD
C
C
C     CONVERT INTO 4 BIT BCD
C
      KA        = ITIME / 1000
      KB        = MOD(ITIME,1000) / 100
      KC        = MOD(ITIME,100) / 10
      KD        = MOD(ITIME,10)
C
      QDESCR(39:39) = CHAR(KA * 16 + KB)
      QDESCR(40:40) = CHAR(kC * 16 + KD)
C
      RETURN
      END