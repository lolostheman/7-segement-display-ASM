	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
    ; Enable the clock to GPIO Port A	
	LDR r0, =RCC_BASE
	LDR r1, [r0, #RCC_AHB2ENR]
	ORR r1, r1, #RCC_AHB2ENR_GPIOAEN
	STR r1, [r0, #RCC_AHB2ENR]
	; Enable the clock to port E
	LDR r0, =RCC_BASE
	LDR r1, [r0, #RCC_AHB2ENR]
	ORR r1, r1, #RCC_AHB2ENR_GPIOEEN
	STR r1, [r0, #RCC_AHB2ENR]
	; Enable the clock to port H
	LDR r0, =RCC_BASE
	LDR r1, [r0, #RCC_AHB2ENR]
	ORR r1, r1, #RCC_AHB2ENR_GPIOHEN
	STR r1, [r0, #RCC_AHB2ENR]
	
	
	;PE10
	LDR r0, =GPIOE_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1,  #(0x3 << 20)
	ORR r1, r1,  #(0x1 << 20)
	STR r1, [r0, #GPIO_MODER]
	
	;LDR r1, [r0, #GPIO_ODR]
	;ORR r1, r1,  #(0x1<<10)
	;STR r1, [r0, #GPIO_ODR]
	
	;PE11
	LDR r0, =GPIOE_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1,  #(0x3 << 22)
	ORR r1, r1,  #(0x1 << 22)
	STR r1, [r0, #GPIO_MODER]
	
	;LDR r1, [r0, #GPIO_ODR]
	;ORR r1, r1,  #(0x1<<11)
	;STR r1, [r0, #GPIO_ODR]
	
	;PE12
	LDR r0, =GPIOE_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1,  #(0x3 << 24)
	ORR r1, r1,  #(0x1 << 24)
	STR r1, [r0, #GPIO_MODER]
	
	;LDR r1, [r0, #GPIO_ODR]
	;ORR r1, r1,  #(0x1<<12)
	;STR r1, [r0, #GPIO_ODR]	
	
	;PE13
	LDR r0, =GPIOE_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1,  #(0x3 << 26)
	ORR r1, r1,  #(0x1 << 26)
	STR r1, [r0, #GPIO_MODER]
	
	;LDR r1, [r0, #GPIO_ODR]
	;ORR r1, r1,  #(0x1<<13)
	;STR r1, [r0, #GPIO_ODR]
	
	;PE14
	LDR r0, =GPIOE_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1,  #(0x3 << 28)
	ORR r1, r1,  #(0x1 << 28)
	STR r1, [r0, #GPIO_MODER]
	
	;LDR r1, [r0, #GPIO_ODR]
	;ORR r1, r1,  #(0x1<<14)
	;STR r1, [r0, #GPIO_ODR]
	
	;PE15
	LDR r0, =GPIOE_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1,  #(0x3 << 30)
	ORR r1, r1,  #(0x1 << 30)
	STR r1, [r0, #GPIO_MODER]
	
	;LDR r1, [r0, #GPIO_ODR]
	;ORR r1, r1,  #(0x1<<15)
	;STR r1, [r0, #GPIO_ODR]
	
	;PH0
	LDR r0, =GPIOH_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1,  #(0x3)
	ORR r1, r1,  #(0x1)
	STR r1, [r0, #GPIO_MODER]
	
	;LDR r1, [r0, #GPIO_ODR]
	;ORR r1, r1,  #(0x1<<0)
	;STR r1, [r0, #GPIO_ODR]
	
	;pin init for pa1 and pa2 for joystick
	LDR r0, =GPIOA_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1, #(0x3 << 6)
	STR r1, [r0, #GPIO_MODER]
	
	LDR r0, =GPIOA_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1, #(0x3 << 10)
	STR r1, [r0, #GPIO_MODER]
	
	LDR r0, =GPIOA_BASE
	LDR r1, [r0, #GPIO_PUPDR]
	ORR r1, r1, #(0x2<<6)
	STR r1, [r0, #GPIO_PUPDR]
	
	LDR r0, =GPIOA_BASE
	LDR r1, [r0, #GPIO_PUPDR]
	ORR r1, r1, #(0x2<<10)
	STR r1, [r0, #GPIO_PUPDR]
	
	
	LDR r5, =0x0
	LDR r4, =0x2710
	LDR r3, =0x0
	LDR r6, =0x0
	LDR r7, =0x0

	ADD r3, r3, #0x1
	;CMP r3, r4
	;BHI delay
	;BLT delayend
delay	
		LDR r8, =GPIOA_BASE
		LDR r6, [r8, #GPIO_IDR]
		AND r6, r6, #GPIO_IDR_IDR_3  ;right joy
		CMP r6, #0x0
		BNE joyup
		BEQ joyupend
joyup
		ADD r5, r5, #1
		LDR r3, =0x0
		B joyupend
joyupend
		LDR r8, =GPIOA_BASE
		LDR r7, [r8, #GPIO_IDR]
		AND r7, r7, #GPIO_IDR_IDR_5
		CMP r7, #0x0
		BNE joydown
		BEQ joydownend
joydown
		SUB r5, r5, #1
		LDR r3, =0x0
		B joydownend
joydownend
		B delayend
delayend
		B zero
		
		
	;BNE one
zero	cmp r5, #0
		BNE one
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<10)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<11)
		STR r1, [r0, #GPIO_ODR]	
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<12)
		STR r1, [r0, #GPIO_ODR]	
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<13)
		STR r1, [r0, #GPIO_ODR]	
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<14)
		STR r1, [r0, #GPIO_ODR]	
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<15)
		STR r1, [r0, #GPIO_ODR]
		b delay
one		CMP r5, #1
		BNE two
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<13)
		STR r1, [r0, #GPIO_ODR]	
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<12)
		STR r1, [r0, #GPIO_ODR]
		b delay
two		CMP r5, #2
		BNE three
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<14)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<13)	
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<11)
		STR r1, [r0, #GPIO_ODR]
		LDR r0, =GPIOH_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<0)
		STR r1, [r0, #GPIO_ODR]
		b delay
three	CMP r5, #3
		BNE four
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<14)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<13)	
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<12)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<11)
		STR r1, [r0, #GPIO_ODR]
		LDR r0, =GPIOH_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<0)
		STR r1, [r0, #GPIO_ODR]
		b delay
four	CMP r5, #4
		BNE five
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<15)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<13)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<12)
		STR r1, [r0, #GPIO_ODR]
		LDR r0, =GPIOH_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<0)
		STR r1, [r0, #GPIO_ODR]
		b delay
five	CMP r5, #5
		BNE six
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<14)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<15)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<12)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<11)
		STR r1, [r0, #GPIO_ODR]
		LDR r0, =GPIOH_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<0)
		STR r1, [r0, #GPIO_ODR]
		b delay
six		CMP r5, #6
		BNE seven
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<14)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<15)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<12)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<11)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<10)
		STR r1, [r0, #GPIO_ODR]
		LDR r0, =GPIOH_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<0)
		STR r1, [r0, #GPIO_ODR]
		b delay
seven	CMP r5, #7
		BNE eight
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<13)
		STR r1, [r0, #GPIO_ODR]	
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<12)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<14)
		STR r1, [r0, #GPIO_ODR]
		b delay
eight	CMP r5, #8
		BNE nine
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<14)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<13)
		STR r1, [r0, #GPIO_ODR]	
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<15)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<12)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<11)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<10)
		STR r1, [r0, #GPIO_ODR]
		LDR r0, =GPIOH_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<0)
		STR r1, [r0, #GPIO_ODR]
		b delay
nine	CMP r5, #9
		BNE exit
		LDR r0, =GPIOE_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<14)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<13)
		STR r1, [r0, #GPIO_ODR]	
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<15)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<12)
		STR r1, [r0, #GPIO_ODR]
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<11)
		STR r1, [r0, #GPIO_ODR]
		LDR r0, =GPIOH_BASE
		LDR r1, [r0, #GPIO_ODR]
		ORR r1, r1,  #(0x1<<0)
		STR r1, [r0, #GPIO_ODR]
		b delay

exit	MOV r5, #0
		B delay
  
stop 	B 		stop     		; dead loop & program hangs here

	ENDP ;end of initializing
		

	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
array	DCD   1, 2, 3, 4
	END
