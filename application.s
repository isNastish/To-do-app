	.file	"application.c"
	.text
	.comm	buf,100,32
	.globl	bufp
	.bss
	.align 4
	.type	bufp, @object
	.size	bufp, 4
bufp:
	.zero	4
	.text
	.globl	mystrlen
	.type	mystrlen, @function
mystrlen:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	addl	$1, -4(%rbp)
	addq	$1, -24(%rbp)
.L2:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L3
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	mystrlen, .-mystrlen
	.globl	mystrcmp
	.type	mystrcmp, @function
mystrcmp:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	jmp	.L6
.L9:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L7
	movl	$0, %eax
	jmp	.L8
.L7:
	addq	$1, -8(%rbp)
	addq	$1, -16(%rbp)
.L6:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	%al, %dl
	je	.L9
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %edx
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	subl	%eax, %edx
	movl	%edx, %eax
.L8:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	mystrcmp, .-mystrcmp
	.data
	.align 16
	.type	daysInmonth, @object
	.size	daysInmonth, 26
daysInmonth:
	.string	""
	.ascii	"\037\034\037\036\037\036\037\037\036\037\036\037"
	.string	""
	.ascii	"\037\035\037\036\037\036\037\037\036\037\036\037"
	.globl	flagsArrayGlob
	.section	.rodata
.LC0:
	.string	"-sh"
.LC1:
	.string	"-d"
.LC2:
	.string	"-a"
.LC3:
	.string	"-c"
.LC4:
	.string	"-ga"
.LC5:
	.string	"-gd"
.LC6:
	.string	"-gc"
.LC7:
	.string	"-gsh"
	.section	.data.rel.local,"aw"
	.align 32
	.type	flagsArrayGlob, @object
	.size	flagsArrayGlob, 128
flagsArrayGlob:
	.quad	.LC0
	.quad	showGlobDataBy
	.quad	.LC1
	.quad	deleteGlobDataBy
	.quad	.LC2
	.quad	addGlobData
	.quad	.LC3
	.quad	changeGlobStatus
	.quad	.LC4
	.quad	addGlobData
	.quad	.LC5
	.quad	deleteGlobDataBy
	.quad	.LC6
	.quad	changeGlobStatus
	.quad	.LC7
	.quad	showGlobDataBy
	.globl	flagsArrayDay
	.section	.rodata
.LC8:
	.string	"-la"
.LC9:
	.string	"-ld"
.LC10:
	.string	"-lc"
.LC11:
	.string	"-lsh"
	.section	.data.rel.local
	.align 32
	.type	flagsArrayDay, @object
	.size	flagsArrayDay, 128
flagsArrayDay:
	.quad	.LC0
	.quad	showDayDataBy
	.quad	.LC1
	.quad	deleteDayDataBy
	.quad	.LC2
	.quad	addDayData
	.quad	.LC3
	.quad	changeDayStatus
	.quad	.LC8
	.quad	addDayData
	.quad	.LC9
	.quad	deleteDayDataBy
	.quad	.LC10
	.quad	changeDayStatus
	.quad	.LC11
	.quad	showDayDataBy
	.comm	inArgsPtr,32,32
	.local	allocatedBuffer
	.comm	allocatedBuffer,1000,32
	.align 8
	.type	allocBufP, @object
	.size	allocBufP, 8
allocBufP:
	.quad	allocatedBuffer
	.section	.rodata
.LC12:
	.string	"clear"
.LC13:
	.string	"dayData.bin"
.LC14:
	.string	"globData.bin"
.LC15:
	.string	"\033[33;1m~:\033[0m"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -60(%rbp)
	movq	-80(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	mystrlen
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, %edi
	call	allocMemory
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L11
	movq	-80(%rbp), %rax
	movq	(%rax), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movl	-56(%rbp), %eax
	movslq	%eax, %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-32(%rbp), %rax
	movq	%rax, inArgsPtr(%rip)
.L11:
	leaq	.LC12(%rip), %rdi
	call	system@PLT
	movq	-24(%rbp), %rax
	leaq	.LC13(%rip), %rsi
	movq	%rax, %rdi
	call	createFile
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rax
	leaq	.LC14(%rip), %rsi
	movq	%rax, %rdi
	call	createFile
	movq	%rax, -16(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	cmpl	$1, -68(%rbp)
	jle	.L14
	movq	-80(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$103, %al
	jne	.L13
	leaq	-60(%rbp), %rdi
	movq	-80(%rbp), %rcx
	movl	-68(%rbp), %edx
	movq	-16(%rbp), %rsi
	movq	-40(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	globmainArgParser
	movq	%rax, -40(%rbp)
	jmp	.L14
.L13:
	movq	-80(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$108, %al
	jne	.L14
	leaq	-60(%rbp), %rdi
	movq	-80(%rbp), %rcx
	movl	-68(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	-48(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	daymainArgParser
	movq	%rax, -48(%rbp)
	jmp	.L14
.L16:
	leaq	.LC15(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	inArgsPtr(%rip), %rdi
	call	insideProgArgParser
	movl	%eax, -52(%rbp)
	cmpl	$1, -52(%rbp)
	jle	.L14
	movq	8+inArgsPtr(%rip), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$103, %al
	jne	.L15
	leaq	-60(%rbp), %rcx
	movl	-52(%rbp), %edx
	movq	-16(%rbp), %rsi
	movq	-40(%rbp), %rax
	movq	%rcx, %r8
	leaq	inArgsPtr(%rip), %rcx
	movq	%rax, %rdi
	call	globmainArgParser
	movq	%rax, -40(%rbp)
	jmp	.L14
.L15:
	movq	8+inArgsPtr(%rip), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$108, %al
	jne	.L14
	leaq	-60(%rbp), %rcx
	movl	-52(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	-48(%rbp), %rax
	movq	%rcx, %r8
	leaq	inArgsPtr(%rip), %rcx
	movq	%rax, %rdi
	call	daymainArgParser
	movq	%rax, -48(%rbp)
.L14:
	movl	-60(%rbp), %eax
	testl	%eax, %eax
	jne	.L16
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L18
	call	__stack_chk_fail@PLT
.L18:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.section	.rodata
.LC16:
	.string	"ab+"
.LC17:
	.string	"error: while openning file!"
	.text
	.globl	createFile
	.type	createFile, @function
createFile:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movabsq	$7020600981791402031, %rax
	movabsq	$8740694577455395955, %rdx
	movq	%rax, -80(%rbp)
	movq	%rdx, -72(%rbp)
	movabsq	$8319383698888684112, %rax
	movabsq	$7002375471680672815, %rdx
	movq	%rax, -64(%rbp)
	movq	%rdx, -56(%rbp)
	movabsq	$7089075250099351664, %rax
	movl	$795177825, %edx
	movq	%rax, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movq	$0, -32(%rbp)
	movl	$0, -24(%rbp)
	movq	-96(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strconcat
	leaq	-80(%rbp), %rax
	leaq	.LC16(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -88(%rbp)
	cmpq	$0, -88(%rbp)
	jne	.L20
	leaq	.LC17(%rip), %rdi
	call	puts@PLT
	movl	$1, %edi
	call	exit@PLT
.L20:
	movq	-88(%rbp), %rax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L22
	call	__stack_chk_fail@PLT
.L22:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	createFile, .-createFile
	.globl	strconcat
	.type	strconcat, @function
strconcat:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	jmp	.L24
.L25:
	addq	$1, -8(%rbp)
.L24:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L25
	nop
.L26:
	movq	-16(%rbp), %rdx
	leaq	1(%rdx), %rax
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, -8(%rbp)
	movzbl	(%rdx), %edx
	movb	%dl, (%rax)
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L26
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	strconcat, .-strconcat
	.globl	tallocGlobalTask
	.type	tallocGlobalTask, @function
tallocGlobalTask:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$64, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	tallocGlobalTask, .-tallocGlobalTask
	.globl	tallocDayTask
	.type	tallocDayTask, @function
tallocDayTask:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$24, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	tallocDayTask, .-tallocDayTask
	.globl	tallocDate
	.type	tallocDate, @function
tallocDate:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$6, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-24(%rbp), %rax
	movzwl	4(%rax), %edx
	movq	-8(%rbp), %rax
	movw	%dx, 4(%rax)
	movq	-24(%rbp), %rax
	movzwl	2(%rax), %edx
	movq	-8(%rbp), %rax
	movw	%dx, 2(%rax)
	movq	-24(%rbp), %rax
	movzwl	(%rax), %edx
	movq	-8(%rbp), %rax
	movw	%dx, (%rax)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	tallocDate, .-tallocDate
	.globl	allocateDescription
	.type	allocateDescription, @function
allocateDescription:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	mystrlen
	addl	$1, %eax
	cltq
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-24(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	allocateDescription, .-allocateDescription
	.section	.rodata
	.align 8
.LC18:
	.string	"allocMemory error: not enough space in buffer!"
	.text
	.globl	allocMemory
	.type	allocMemory, @function
allocMemory:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	leaq	1000+allocatedBuffer(%rip), %rdx
	movq	allocBufP(%rip), %rax
	subq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	cmpq	%rax, %rdx
	jl	.L36
	movq	allocBufP(%rip), %rdx
	movl	-4(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movq	%rax, allocBufP(%rip)
	movq	allocBufP(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	negq	%rdx
	addq	%rdx, %rax
	jmp	.L35
.L36:
	leaq	.LC18(%rip), %rdi
	call	puts@PLT
.L35:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	allocMemory, .-allocMemory
	.globl	freeAllocMem
	.type	freeAllocMem, @function
freeAllocMem:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	leaq	allocatedBuffer(%rip), %rax
	cmpq	%rax, -8(%rbp)
	jb	.L40
	leaq	1000+allocatedBuffer(%rip), %rax
	cmpq	%rax, -8(%rbp)
	jnb	.L40
	movq	-8(%rbp), %rax
	movq	%rax, allocBufP(%rip)
.L40:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	freeAllocMem, .-freeAllocMem
	.globl	mygetLine
	.type	mygetLine, @function
mygetLine:
.LFB17:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L42
.L44:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-5(%rbp), %eax
	movb	%al, (%rdx)
	addl	$1, -4(%rbp)
.L42:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jge	.L43
	call	getchar@PLT
	movb	%al, -5(%rbp)
	cmpb	$-1, -5(%rbp)
	je	.L43
	cmpb	$10, -5(%rbp)
	jne	.L44
.L43:
	cmpb	$10, -5(%rbp)
	jne	.L45
	movl	-4(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -4(%rbp)
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-5(%rbp), %eax
	movb	%al, (%rdx)
.L45:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movl	-4(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	mygetLine, .-mygetLine
	.globl	insideProgArgParser
	.type	insideProgArgParser, @function
insideProgArgParser:
.LFB18:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	movq	%rdi, -216(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$1, -196(%rbp)
	movl	$0, -192(%rbp)
	leaq	-112(%rbp), %rax
	movl	$100, %esi
	movq	%rax, %rdi
	call	mygetLine
	movl	%eax, -188(%rbp)
	movl	$0, -200(%rbp)
	jmp	.L48
.L57:
	call	__ctype_b_loc@PLT
	movq	(%rax), %rdx
	movl	-200(%rbp), %eax
	cltq
	movzbl	-112(%rbp,%rax), %eax
	movsbq	%al, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	jne	.L49
	movl	-200(%rbp), %eax
	cltq
	movzbl	-112(%rbp,%rax), %edx
	movl	-192(%rbp), %eax
	cltq
	movb	%dl, -176(%rbp,%rax)
	addl	$1, -192(%rbp)
	jmp	.L50
.L49:
	movl	-192(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %edi
	call	allocMemory
	movq	%rax, -184(%rbp)
	cmpq	$0, -184(%rbp)
	je	.L51
	movl	-192(%rbp), %eax
	cltq
	movb	$0, -176(%rbp,%rax)
	leaq	-176(%rbp), %rdx
	movq	-184(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movl	-196(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -196(%rbp)
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-216(%rbp), %rax
	addq	%rax, %rdx
	movq	-184(%rbp), %rax
	movq	%rax, (%rdx)
	movl	$0, -192(%rbp)
.L51:
	movl	-200(%rbp), %eax
	addl	$1, %eax
	cltq
	movzbl	-112(%rbp,%rax), %eax
	cmpb	$45, %al
	je	.L60
	movl	-200(%rbp), %eax
	cltq
	movzbl	-112(%rbp,%rax), %eax
	cmpb	$10, %al
	je	.L60
	addl	$1, -200(%rbp)
	movl	$0, -192(%rbp)
	jmp	.L53
.L54:
	movl	-200(%rbp), %eax
	cltq
	movzbl	-112(%rbp,%rax), %edx
	movl	-192(%rbp), %eax
	cltq
	movb	%dl, -176(%rbp,%rax)
	addl	$1, -200(%rbp)
	addl	$1, -192(%rbp)
.L53:
	movl	-200(%rbp), %eax
	cmpl	-188(%rbp), %eax
	jl	.L54
	movl	-192(%rbp), %eax
	movl	%eax, %edi
	call	allocMemory
	movq	%rax, -184(%rbp)
	cmpq	$0, -184(%rbp)
	je	.L50
	movl	-192(%rbp), %eax
	subl	$1, %eax
	cltq
	movb	$0, -176(%rbp,%rax)
	leaq	-176(%rbp), %rdx
	movq	-184(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movl	-196(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -196(%rbp)
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-216(%rbp), %rax
	addq	%rax, %rdx
	movq	-184(%rbp), %rax
	movq	%rax, (%rdx)
	jmp	.L56
.L60:
	nop
.L50:
	addl	$1, -200(%rbp)
.L48:
	movl	-200(%rbp), %eax
	cmpl	-188(%rbp), %eax
	jl	.L57
.L56:
	movl	-196(%rbp), %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L59
	call	__stack_chk_fail@PLT
.L59:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	insideProgArgParser, .-insideProgArgParser
	.globl	compareDates
	.type	compareDates, @function
compareDates:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movzwl	(%rax), %edx
	movq	-16(%rbp), %rax
	movzwl	(%rax), %eax
	cmpw	%ax, %dx
	ja	.L62
	movq	-8(%rbp), %rax
	movzwl	(%rax), %edx
	movq	-16(%rbp), %rax
	movzwl	(%rax), %eax
	cmpw	%ax, %dx
	jnb	.L63
.L62:
	movq	-8(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %edx
	movq	-16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	jmp	.L64
.L63:
	movq	-8(%rbp), %rax
	movzwl	2(%rax), %edx
	movq	-16(%rbp), %rax
	movzwl	2(%rax), %eax
	cmpw	%ax, %dx
	ja	.L65
	movq	-8(%rbp), %rax
	movzwl	2(%rax), %edx
	movq	-16(%rbp), %rax
	movzwl	2(%rax), %eax
	cmpw	%ax, %dx
	jnb	.L66
.L65:
	movq	-8(%rbp), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %edx
	movq	-16(%rbp), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	jmp	.L64
.L66:
	movq	-8(%rbp), %rax
	movzwl	4(%rax), %edx
	movq	-16(%rbp), %rax
	movzwl	4(%rax), %eax
	cmpw	%ax, %dx
	ja	.L67
	movq	-8(%rbp), %rax
	movzwl	4(%rax), %edx
	movq	-16(%rbp), %rax
	movzwl	4(%rax), %eax
	cmpw	%ax, %dx
	jnb	.L68
.L67:
	movq	-8(%rbp), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %edx
	movq	-16(%rbp), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	jmp	.L64
.L68:
	movl	$0, %eax
.L64:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	compareDates, .-compareDates
	.globl	amountOfDaysPerTask
	.type	amountOfDaysPerTask, @function
amountOfDaysPerTask:
.LFB20:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	-40(%rbp), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %edx
	movq	-40(%rbp), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %ecx
	movq	-40(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	dayOfyear
	movl	%eax, -20(%rbp)
	movq	-48(%rbp), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %edx
	movq	-48(%rbp), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %ecx
	movq	-48(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	movl	%ecx, %esi
	movl	%eax, %edi
	call	dayOfyear
	movl	%eax, -16(%rbp)
	movq	-40(%rbp), %rax
	movzwl	(%rax), %edx
	movq	-48(%rbp), %rax
	movzwl	(%rax), %eax
	cmpw	%ax, %dx
	jne	.L70
	movl	-16(%rbp), %eax
	subl	-20(%rbp), %eax
	jmp	.L71
.L70:
	movq	-40(%rbp), %rax
	movzwl	(%rax), %eax
	andl	$3, %eax
	testw	%ax, %ax
	jne	.L72
	movq	-40(%rbp), %rax
	movzwl	(%rax), %ecx
	movl	%ecx, %eax
	shrw	$2, %ax
	movzwl	%ax, %eax
	imull	$5243, %eax, %eax
	shrl	$16, %eax
	movl	%eax, %edx
	shrw	%dx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	leal	0(,%rax,4), %edx
	addl	%edx, %eax
	sall	$2, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	testw	%dx, %dx
	jne	.L73
.L72:
	movq	-40(%rbp), %rax
	movzwl	(%rax), %edx
	movl	%edx, %eax
	shrw	$4, %ax
	movzwl	%ax, %eax
	imull	$2622, %eax, %eax
	shrl	$16, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	leal	0(,%rax,4), %ecx
	addl	%ecx, %eax
	sall	$4, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	testw	%ax, %ax
	jne	.L74
.L73:
	movl	$1, %eax
	jmp	.L75
.L74:
	movl	$0, %eax
.L75:
	movl	%eax, -12(%rbp)
	movq	-48(%rbp), %rax
	movzwl	(%rax), %eax
	andl	$3, %eax
	testw	%ax, %ax
	jne	.L76
	movq	-48(%rbp), %rax
	movzwl	(%rax), %ecx
	movl	%ecx, %eax
	shrw	$2, %ax
	movzwl	%ax, %eax
	imull	$5243, %eax, %eax
	shrl	$16, %eax
	movl	%eax, %edx
	shrw	%dx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	leal	0(,%rax,4), %edx
	addl	%edx, %eax
	sall	$2, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	testw	%dx, %dx
	jne	.L77
.L76:
	movq	-48(%rbp), %rax
	movzwl	(%rax), %edx
	movl	%edx, %eax
	shrw	$4, %ax
	movzwl	%ax, %eax
	imull	$2622, %eax, %eax
	shrl	$16, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	leal	0(,%rax,4), %ecx
	addl	%ecx, %eax
	sall	$4, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	testw	%ax, %ax
	jne	.L78
.L77:
	movl	$1, %eax
	jmp	.L79
.L78:
	movl	$0, %eax
.L79:
	movl	%eax, -8(%rbp)
	movq	-48(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %edx
	movq	-40(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	addl	$1, %eax
	cmpl	%eax, %edx
	jne	.L80
	cmpl	$0, -12(%rbp)
	je	.L81
	movl	$366, %eax
	subl	-20(%rbp), %eax
	movl	%eax, %edx
	movl	-16(%rbp), %eax
	addl	%edx, %eax
	jmp	.L71
.L81:
	movl	$365, %eax
	subl	-20(%rbp), %eax
	movl	%eax, %edx
	movl	-16(%rbp), %eax
	addl	%edx, %eax
	jmp	.L71
.L80:
	movl	$0, -24(%rbp)
	movq	-48(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	subl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.L82
.L89:
	movl	-28(%rbp), %eax
	andl	$3, %eax
	testl	%eax, %eax
	jne	.L83
	movl	-28(%rbp), %edx
	movslq	%edx, %rax
	imulq	$1374389535, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %ecx
	sarl	$5, %ecx
	movl	%edx, %eax
	sarl	$31, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	imull	$100, %eax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	.L84
.L83:
	movl	-28(%rbp), %edx
	movslq	%edx, %rax
	imulq	$1374389535, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %ecx
	sarl	$7, %ecx
	movl	%edx, %eax
	sarl	$31, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	imull	$400, %eax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	.L85
.L84:
	movl	$1, %eax
	jmp	.L86
.L85:
	movl	$0, %eax
.L86:
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	je	.L87
	movl	$366, %eax
	jmp	.L88
.L87:
	movl	$365, %eax
.L88:
	addl	%eax, -24(%rbp)
	subl	$1, -28(%rbp)
.L82:
	movq	-40(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	cmpl	%eax, -28(%rbp)
	jg	.L89
	cmpl	$0, -12(%rbp)
	je	.L90
	movl	$366, %eax
	subl	-20(%rbp), %eax
	movl	%eax, %edx
	movl	-24(%rbp), %eax
	addl	%eax, %edx
	movl	-16(%rbp), %eax
	addl	%edx, %eax
	jmp	.L71
.L90:
	movl	$365, %eax
	subl	-20(%rbp), %eax
	movl	%eax, %edx
	movl	-24(%rbp), %eax
	addl	%eax, %edx
	movl	-16(%rbp), %eax
	addl	%edx, %eax
.L71:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	amountOfDaysPerTask, .-amountOfDaysPerTask
	.globl	dayOfyear
	.type	dayOfyear, @function
dayOfyear:
.LFB21:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	-20(%rbp), %eax
	andl	$3, %eax
	testl	%eax, %eax
	jne	.L92
	movl	-20(%rbp), %edx
	movslq	%edx, %rax
	imulq	$1374389535, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %ecx
	sarl	$5, %ecx
	movl	%edx, %eax
	sarl	$31, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	imull	$100, %eax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	.L93
.L92:
	movl	-20(%rbp), %edx
	movslq	%edx, %rax
	imulq	$1374389535, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %ecx
	sarl	$7, %ecx
	movl	%edx, %eax
	sarl	$31, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	imull	$400, %eax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	.L94
.L93:
	movl	$1, %eax
	jmp	.L95
.L94:
	movl	$0, %eax
.L95:
	movl	%eax, -4(%rbp)
	movl	$1, -8(%rbp)
	jmp	.L96
.L97:
	movl	-8(%rbp), %eax
	movslq	%eax, %rcx
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	leaq	daysInmonth(%rip), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	addl	%eax, -28(%rbp)
	addl	$1, -8(%rbp)
.L96:
	movl	-8(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.L97
	movl	-28(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	dayOfyear, .-dayOfyear
	.section	.rodata
.LC19:
	.string	"in progress"
	.text
	.globl	createGlobalTree
	.type	createGlobalTree, @function
createGlobalTree:
.LFB22:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movq	%r8, -72(%rbp)
	movq	%r9, -80(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L100
	call	tallocGlobalTask
	movq	%rax, -40(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	allocateDescription
	movq	-40(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	allocateDescription
	movq	-40(%rbp), %rdx
	movq	%rax, 40(%rdx)
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	tallocDate
	movq	-40(%rbp), %rdx
	movq	%rax, 16(%rdx)
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	tallocDate
	movq	-40(%rbp), %rdx
	movq	%rax, 24(%rdx)
	movq	-40(%rbp), %rax
	movq	24(%rax), %rdx
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	amountOfDaysPerTask
	movq	-40(%rbp), %rdx
	movl	%eax, 8(%rdx)
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	allocateDescription
	movq	-40(%rbp), %rdx
	movq	%rax, 32(%rdx)
	movq	-40(%rbp), %rax
	movq	$0, 56(%rax)
	movq	-40(%rbp), %rax
	movq	56(%rax), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, 48(%rax)
	jmp	.L101
.L100:
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	compareDates
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jne	.L102
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	testq	%rax, %rax
	je	.L103
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-72(%rbp), %rsi
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rax
	leaq	.LC19(%rip), %r9
	movq	%rsi, %r8
	movq	%rax, %rsi
	movl	$0, %edi
	call	createGlobalTree
	movq	-40(%rbp), %rdx
	movq	%rax, 48(%rdx)
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 48(%rax)
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 56(%rax)
	jmp	.L101
.L103:
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rsi
	leaq	.LC19(%rip), %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	createGlobalTree
	movq	-40(%rbp), %rdx
	movq	%rax, 48(%rdx)
	jmp	.L101
.L102:
	cmpl	$0, -20(%rbp)
	jle	.L104
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rsi
	leaq	.LC19(%rip), %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	createGlobalTree
	movq	-40(%rbp), %rdx
	movq	%rax, 48(%rdx)
	jmp	.L101
.L104:
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	movq	-72(%rbp), %rdi
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rsi
	leaq	.LC19(%rip), %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	createGlobalTree
	movq	-40(%rbp), %rdx
	movq	%rax, 56(%rdx)
.L101:
	movq	-40(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	createGlobalTree, .-createGlobalTree
	.globl	readGlobStructFromFile
	.type	readGlobStructFromFile, @function
readGlobStructFromFile:
.LFB23:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -88(%rbp)
	jmp	.L107
.L109:
	movq	$0, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -32(%rbp)
	cmpl	$0, -88(%rbp)
	jne	.L108
	movl	-72(%rbp), %eax
	cltq
	movq	%rax, %rdi
	movq	-80(%rbp), %rsi
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rdx
	movq	-64(%rbp), %rax
	movq	%rdi, %r9
	movq	%rsi, %r8
	movq	%rax, %rsi
	movl	$0, %edi
	call	createGlobalTree
	movq	%rax, -104(%rbp)
	movl	$1, -88(%rbp)
	jmp	.L107
.L108:
	movq	-48(%rbp), %r8
	movq	-80(%rbp), %rdi
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rdx
	movq	-64(%rbp), %rsi
	movq	-104(%rbp), %rax
	movq	%r8, %r9
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	createGlobalTree
	movq	%rax, -104(%rbp)
.L107:
	movq	-112(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$64, %esi
	movq	%rax, %rdi
	call	fread@PLT
	movl	%eax, -84(%rbp)
	cmpl	$0, -84(%rbp)
	jne	.L109
	movq	-104(%rbp), %rax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L111
	call	__stack_chk_fail@PLT
.L111:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	readGlobStructFromFile, .-readGlobStructFromFile
	.globl	writeGlobStructToFile
	.type	writeGlobStructToFile, @function
writeGlobStructToFile:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L114
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$64, %esi
	movq	%rax, %rdi
	call	fwrite@PLT
	movq	-8(%rbp), %rax
	movq	48(%rax), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	writeGlobStructToFile
	movq	-8(%rbp), %rax
	movq	56(%rax), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	writeGlobStructToFile
.L114:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	writeGlobStructToFile, .-writeGlobStructToFile
	.section	.rodata
.LC20:
	.string	"\033[35;1m  |"
.LC21:
	.string	"\033[36;1m%5d\033[0m"
.LC22:
	.string	"\033[35;1m|\033[0m"
.LC23:
	.string	"  %d."
.LC24:
	.string	"  0%d."
.LC25:
	.string	"%d."
.LC26:
	.string	"0%d."
.LC27:
	.string	"%d  "
.LC28:
	.string	"%5d"
.LC29:
	.string	"\033[0m"
.LC30:
	.string	"\033[33;1m %s  "
.LC31:
	.string	"done"
.LC32:
	.string	"\033[32m     %s     "
.LC33:
	.string	"denied"
.LC34:
	.string	"\033[31m    %s    "
.LC35:
	.string	"\033[35;1m|\n\033[0m"
.LC36:
	.string	"|\n\033[0m"
	.text
	.globl	globTreeprint
	.type	globTreeprint, @function
globTreeprint:
.LFB25:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L134
	movq	-24(%rbp), %rax
	movq	48(%rax), %rax
	movl	-28(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	globTreeprint
	addl	$1, -28(%rbp)
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-28(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC21(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	4(%rax), %eax
	cmpw	$9, %ax
	jbe	.L117
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC23(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L118
.L117:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC24(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L118:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	2(%rax), %eax
	cmpw	$9, %ax
	jbe	.L119
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC25(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L120
.L119:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC26(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L120:
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC27(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	4(%rax), %eax
	cmpw	$9, %ax
	jbe	.L121
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC23(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L122
.L121:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC24(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L122:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	2(%rax), %eax
	cmpw	$9, %ax
	jbe	.L123
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC25(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L124
.L123:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC26(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L124:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC27(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, %esi
	leaq	.LC28(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	32(%rax), %rax
	leaq	.LC19(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L125
	movq	-24(%rbp), %rax
	movq	32(%rax), %rax
	leaq	.LC29(%rip), %rdx
	movq	%rax, %rsi
	leaq	.LC30(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L126
.L125:
	movq	-24(%rbp), %rax
	movq	32(%rax), %rax
	leaq	.LC31(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L127
	movq	-24(%rbp), %rax
	movq	32(%rax), %rax
	leaq	.LC29(%rip), %rdx
	movq	%rax, %rsi
	leaq	.LC32(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L126
.L127:
	movq	-24(%rbp), %rax
	movq	32(%rax), %rax
	leaq	.LC33(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L126
	movq	-24(%rbp), %rax
	movq	32(%rax), %rax
	leaq	.LC29(%rip), %rdx
	movq	%rax, %rsi
	leaq	.LC34(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L126:
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -12(%rbp)
	jmp	.L128
.L129:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -12(%rbp)
.L128:
	cmpl	$34, -12(%rbp)
	jle	.L129
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -8(%rbp)
	jmp	.L130
.L131:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -8(%rbp)
.L130:
	cmpl	$76, -8(%rbp)
	jle	.L131
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -4(%rbp)
	jmp	.L132
.L133:
	movl	$45, %edi
	call	putchar@PLT
	addl	$1, -4(%rbp)
.L132:
	cmpl	$169, -4(%rbp)
	jle	.L133
	leaq	.LC36(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	56(%rax), %rax
	movl	-28(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	globTreeprint
	addl	$1, -28(%rbp)
.L134:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	globTreeprint, .-globTreeprint
	.section	.rodata
.LC37:
	.string	"\033[36;1m\t\t\t\t\t\t\t\t\t\tGLOBAL TASKS"
.LC38:
	.string	"\033[35;1m   __"
.LC39:
	.string	"\033[35;1m __"
.LC40:
	.string	"\033[34m  \342\204\226  \033[0m"
.LC41:
	.string	"\033[35;1m-"
.LC42:
	.string	"\033[35;1m|"
.LC43:
	.string	"\033[34m  start date  "
.LC44:
	.string	"\033[34m  finish date "
.LC45:
	.string	"\033[34m day "
.LC46:
	.string	"\033[34m    status   "
.LC47:
	.string	"\033[34m\t\t task name\t       "
.LC48:
	.string	"\033[34m\t\t\t\tdescription\t\t\t\t    "
.LC49:
	.string	"\033[35;1m "
.LC50:
	.string	"\033[35;1m  |__"
.LC51:
	.string	"|__"
.LC52:
	.string	"|\n\n\033[0m"
	.text
	.globl	displayAllGlobData
	.type	displayAllGlobData, @function
displayAllGlobData:
.LFB26:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, -24(%rbp)
	leaq	.LC37(%rip), %rdi
	call	puts@PLT
	leaq	.LC38(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -20(%rbp)
	jmp	.L136
.L137:
	leaq	.LC39(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -20(%rbp)
.L136:
	cmpl	$55, -20(%rbp)
	jle	.L137
	movl	$10, %edi
	call	putchar@PLT
	movl	$0, -16(%rbp)
	jmp	.L138
.L152:
	cmpl	$1, -16(%rbp)
	jg	.L139
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L140
	leaq	.LC40(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$5, -24(%rbp)
.L140:
	movl	-24(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.L141
.L150:
	cmpl	$1, -16(%rbp)
	jne	.L142
	leaq	.LC41(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L143
.L142:
	cmpl	$5, -12(%rbp)
	jne	.L144
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L143
	leaq	.LC43(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$19, -12(%rbp)
	jmp	.L143
.L144:
	cmpl	$20, -12(%rbp)
	jne	.L145
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L143
	leaq	.LC44(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$34, -12(%rbp)
	jmp	.L143
.L145:
	cmpl	$35, -12(%rbp)
	jne	.L146
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L143
	leaq	.LC45(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$40, -12(%rbp)
	jmp	.L143
.L146:
	cmpl	$41, -12(%rbp)
	jne	.L147
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L143
	leaq	.LC46(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$54, -12(%rbp)
	jmp	.L143
.L147:
	cmpl	$56, -12(%rbp)
	jne	.L148
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L143
	leaq	.LC47(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$91, -12(%rbp)
	jmp	.L143
.L148:
	cmpl	$92, -12(%rbp)
	jne	.L149
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L143
	leaq	.LC48(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$168, -12(%rbp)
	jmp	.L143
.L149:
	leaq	.LC49(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L143:
	addl	$1, -12(%rbp)
.L141:
	cmpl	$169, -12(%rbp)
	jle	.L150
	leaq	.LC42(%rip), %rdi
	call	puts@PLT
	movl	$0, -24(%rbp)
	jmp	.L151
.L139:
	cmpl	$2, -16(%rbp)
	jne	.L151
	movl	-4(%rbp), %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	globTreeprint
	movl	$10, %edi
	call	putchar@PLT
.L151:
	addl	$1, -16(%rbp)
.L138:
	cmpl	$2, -16(%rbp)
	jle	.L152
	leaq	.LC50(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -8(%rbp)
	jmp	.L153
.L161:
	cmpl	$1, -8(%rbp)
	jne	.L154
	leaq	.LC51(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L155
.L154:
	cmpl	$6, -8(%rbp)
	jne	.L156
	leaq	.LC51(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L155
.L156:
	cmpl	$11, -8(%rbp)
	jne	.L157
	leaq	.LC51(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L155
.L157:
	cmpl	$13, -8(%rbp)
	jne	.L158
	leaq	.LC51(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L155
.L158:
	cmpl	$18, -8(%rbp)
	jne	.L159
	leaq	.LC51(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L155
.L159:
	cmpl	$30, -8(%rbp)
	jne	.L160
	leaq	.LC51(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L155
.L160:
	leaq	.LC39(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L155:
	addl	$1, -8(%rbp)
.L153:
	cmpl	$55, -8(%rbp)
	jle	.L161
	leaq	.LC52(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	displayAllGlobData, .-displayAllGlobData
	.section	.rodata
.LC53:
	.string	"\033[32mstart date: \033[0m"
.LC54:
	.string	"\033[32mfinish date: \033[0m"
.LC55:
	.string	"\033[32mdescription: \033[0m"
.LC56:
	.string	"\033[32mheader: \033[0m"
.LC57:
	.string	"\033[31mAdd more data?\033[0m"
.LC58:
	.string	"%c"
	.text
	.globl	addGlobData
	.type	addGlobData, @function
addGlobData:
.LFB27:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$4096, %rsp
	orq	$0, (%rsp)
	subq	$4096, %rsp
	orq	$0, (%rsp)
	subq	$2160, %rsp
	movq	%rdi, -10344(%rbp)
	movq	%rsi, -10352(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -10328(%rbp)
	movb	$121, -10330(%rbp)
	jmp	.L163
.L167:
	leaq	.LC53(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-10294(%rbp), %rax
	movl	$11, %esi
	movq	%rax, %rdi
	call	mygetLine
	movl	%eax, -10324(%rbp)
	movl	-10324(%rbp), %eax
	cltq
	leaq	-1(%rax), %rdx
	leaq	-10294(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	leaq	.LC54(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-10283(%rbp), %rax
	movl	$11, %esi
	movq	%rax, %rdi
	call	mygetLine
	movl	%eax, -10320(%rbp)
	movl	-10320(%rbp), %eax
	cltq
	leaq	-1(%rax), %rdx
	leaq	-10283(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	leaq	.LC55(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-10016(%rbp), %rax
	movl	$10000, %esi
	movq	%rax, %rdi
	call	mygetLine
	movl	%eax, -10316(%rbp)
	movl	-10316(%rbp), %eax
	cltq
	leaq	-1(%rax), %rdx
	leaq	-10016(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	cmpl	$0, -10328(%rbp)
	jle	.L164
	leaq	.LC56(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-10272(%rbp), %rax
	movl	$250, %esi
	movq	%rax, %rdi
	call	mygetLine
	movl	%eax, -10312(%rbp)
	movl	-10312(%rbp), %eax
	cltq
	leaq	-1(%rax), %rdx
	leaq	-10272(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
.L164:
	movl	-10324(%rbp), %edx
	leaq	-10294(%rbp), %rcx
	leaq	-10306(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	dateParser
	movl	-10320(%rbp), %edx
	leaq	-10283(%rbp), %rcx
	leaq	-10300(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	dateParser
	cmpl	$0, -10328(%rbp)
	je	.L165
	leaq	-10272(%rbp), %rax
	jmp	.L166
.L165:
	movq	-10352(%rbp), %rax
.L166:
	leaq	-10016(%rbp), %rcx
	leaq	-10300(%rbp), %rdx
	leaq	-10306(%rbp), %rsi
	movq	-10344(%rbp), %rdi
	leaq	.LC19(%rip), %r9
	movq	%rax, %r8
	call	createGlobalTree
	movq	%rax, -10344(%rbp)
	leaq	.LC57(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-10330(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC58(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-10329(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC58(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	addl	$1, -10328(%rbp)
.L163:
	movzbl	-10330(%rbp), %eax
	cmpb	$110, %al
	jne	.L167
	leaq	.LC12(%rip), %rdi
	call	system@PLT
	movq	-10344(%rbp), %rax
	movq	%rax, %rdi
	call	displayAllGlobData
	movq	-10344(%rbp), %rax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L169
	call	__stack_chk_fail@PLT
.L169:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	addGlobData, .-addGlobData
	.globl	dateParser
	.type	dateParser, @function
dateParser:
.LFB28:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movl	%edx, -52(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L171
.L178:
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$46, %al
	je	.L172
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movl	-24(%rbp), %eax
	cltq
	movb	%dl, -13(%rbp,%rax)
	addl	$1, -24(%rbp)
	jmp	.L173
.L172:
	addl	$1, -28(%rbp)
	cmpl	$1, -28(%rbp)
	jne	.L174
	movl	-24(%rbp), %eax
	cltq
	movb	$0, -13(%rbp,%rax)
	leaq	-13(%rbp), %rax
	movq	%rax, %rdi
	call	myatoi
	movq	-40(%rbp), %rdx
	movw	%ax, 4(%rdx)
	movl	$0, -24(%rbp)
	jmp	.L173
.L174:
	cmpl	$2, -28(%rbp)
	jne	.L173
	movl	-24(%rbp), %eax
	cltq
	movb	$0, -13(%rbp,%rax)
	leaq	-13(%rbp), %rax
	movq	%rax, %rdi
	call	myatoi
	movq	-40(%rbp), %rdx
	movw	%ax, 2(%rdx)
	movl	$0, -24(%rbp)
	addl	$1, -20(%rbp)
	jmp	.L175
.L176:
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movl	-24(%rbp), %eax
	cltq
	movb	%dl, -13(%rbp,%rax)
	addl	$1, -24(%rbp)
	addl	$1, -20(%rbp)
.L175:
	movl	-20(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jl	.L176
	movl	-24(%rbp), %eax
	cltq
	movb	$0, -13(%rbp,%rax)
	leaq	-13(%rbp), %rax
	movq	%rax, %rdi
	call	myatoi
	movq	-40(%rbp), %rdx
	movw	%ax, (%rdx)
	jmp	.L170
.L173:
	addl	$1, -20(%rbp)
.L171:
	movl	-20(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jl	.L178
.L170:
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L179
	call	__stack_chk_fail@PLT
.L179:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.size	dateParser, .-dateParser
	.globl	myatoi
	.type	myatoi, @function
myatoi:
.LFB29:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$48, %al
	jne	.L181
	movl	$1, -4(%rbp)
	jmp	.L183
.L181:
	movl	$0, -4(%rbp)
	jmp	.L183
.L184:
	addl	$1, -4(%rbp)
.L183:
	call	__ctype_b_loc@PLT
	movq	(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rdx), %edx
	movsbq	%dl, %rdx
	addq	%rdx, %rdx
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	jne	.L184
	movw	$0, -6(%rbp)
	jmp	.L185
.L186:
	movzwl	-6(%rbp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, %ecx
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cbtw
	addl	%ecx, %eax
	subl	$48, %eax
	movw	%ax, -6(%rbp)
	addl	$1, -4(%rbp)
.L185:
	call	__ctype_b_loc@PLT
	movq	(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rdx), %edx
	movsbq	%dl, %rdx
	addq	%rdx, %rdx
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$2048, %eax
	testl	%eax, %eax
	jne	.L186
	movzwl	-6(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	myatoi, .-myatoi
	.section	.rodata
	.align 8
.LC59:
	.string	"\033[31;1mdate (%d %d %d) wasn't found.\n\033[0m"
	.text
	.globl	changeGlobStatus
	.type	changeGlobStatus, @function
changeGlobStatus:
.LFB30:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-48(%rbp), %rcx
	leaq	-22(%rbp), %rax
	movl	$11, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	dateParser
	leaq	-22(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	findstatusinTree
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L189
	movzwl	-22(%rbp), %eax
	movzwl	%ax, %ecx
	movzwl	-20(%rbp), %eax
	movzwl	%ax, %edx
	movzwl	-18(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC59(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L189:
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L191
	call	__stack_chk_fail@PLT
.L191:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	changeGlobStatus, .-changeGlobStatus
	.section	.rodata
.LC60:
	.string	"\033[32mstatus: \033[0m"
	.text
	.globl	findstatusinTree
	.type	findstatusinTree, @function
findstatusinTree:
.LFB31:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpq	$0, -40(%rbp)
	jne	.L193
	movl	$0, %eax
	jmp	.L192
.L193:
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	compareDates
	movl	%eax, -28(%rbp)
	cmpl	$0, -28(%rbp)
	jle	.L195
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	findstatusinTree
	jmp	.L196
.L195:
	cmpl	$0, -28(%rbp)
	jns	.L197
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	findstatusinTree
	jmp	.L196
.L197:
	leaq	.LC60(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-20(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	mygetLine
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	cltq
	leaq	-1(%rax), %rdx
	leaq	-20(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-40(%rbp), %rax
	movq	32(%rax), %rax
	leaq	-20(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-40(%rbp), %rax
	jmp	.L192
.L196:
.L192:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L198
	call	__stack_chk_fail@PLT
.L198:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.size	findstatusinTree, .-findstatusinTree
	.globl	showGlobDataBy
	.type	showGlobDataBy, @function
showGlobDataBy:
.LFB32:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-48(%rbp), %rcx
	leaq	-22(%rbp), %rax
	movl	$11, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	dateParser
	leaq	-22(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	finddateinTree
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L200
	movzwl	-22(%rbp), %eax
	movzwl	%ax, %ecx
	movzwl	-20(%rbp), %eax
	movzwl	%ax, %edx
	movzwl	-18(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC59(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L200:
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L202
	call	__stack_chk_fail@PLT
.L202:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.size	showGlobDataBy, .-showGlobDataBy
	.section	.rodata
.LC61:
	.string	"  "
	.align 8
.LC62:
	.string	"\033[34m             task name             "
	.align 8
.LC63:
	.string	"\033[34m                                description                                 "
	.text
	.globl	finddateinTree
	.type	finddateinTree, @function
finddateinTree:
.LFB33:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L204
	movl	$0, %eax
	jmp	.L203
.L204:
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	compareDates
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jle	.L206
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	finddateinTree
	jmp	.L207
.L206:
	cmpl	$0, -4(%rbp)
	jns	.L208
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	finddateinTree
	jmp	.L207
.L208:
	movl	$0, -24(%rbp)
	leaq	.LC37(%rip), %rdi
	call	puts@PLT
	leaq	.LC38(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -20(%rbp)
	jmp	.L209
.L210:
	leaq	.LC39(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -20(%rbp)
.L209:
	cmpl	$55, -20(%rbp)
	jle	.L210
	movl	$10, %edi
	call	putchar@PLT
	movl	$0, -16(%rbp)
	jmp	.L211
.L229:
	leaq	.LC61(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L212
	leaq	.LC40(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$5, -24(%rbp)
.L212:
	movl	-24(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.L213
.L228:
	cmpl	$1, -16(%rbp)
	jne	.L214
	leaq	.LC41(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L215
.L214:
	cmpl	$5, -12(%rbp)
	jne	.L216
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L235
	leaq	.LC43(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$19, -12(%rbp)
	jmp	.L235
.L216:
	cmpl	$20, -12(%rbp)
	jne	.L218
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L236
	leaq	.LC44(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$34, -12(%rbp)
	jmp	.L236
.L218:
	cmpl	$35, -12(%rbp)
	jne	.L220
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L237
	leaq	.LC45(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$40, -12(%rbp)
	jmp	.L237
.L220:
	cmpl	$41, -12(%rbp)
	jne	.L222
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L238
	leaq	.LC46(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$54, -12(%rbp)
	jmp	.L238
.L222:
	cmpl	$56, -12(%rbp)
	jne	.L224
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L239
	leaq	.LC62(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$91, -12(%rbp)
	jmp	.L239
.L224:
	cmpl	$92, -12(%rbp)
	jne	.L226
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -16(%rbp)
	jne	.L240
	leaq	.LC63(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$168, -12(%rbp)
	jmp	.L240
.L226:
	leaq	.LC49(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L215
.L235:
	nop
	jmp	.L215
.L236:
	nop
	jmp	.L215
.L237:
	nop
	jmp	.L215
.L238:
	nop
	jmp	.L215
.L239:
	nop
	jmp	.L215
.L240:
	nop
.L215:
	addl	$1, -12(%rbp)
.L213:
	cmpl	$169, -12(%rbp)
	jle	.L228
	leaq	.LC42(%rip), %rdi
	call	puts@PLT
	movl	$0, -24(%rbp)
	addl	$1, -16(%rbp)
.L211:
	cmpl	$19, -16(%rbp)
	jle	.L229
	leaq	.LC50(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -8(%rbp)
	jmp	.L230
.L234:
	cmpl	$1, -8(%rbp)
	je	.L231
	cmpl	$6, -8(%rbp)
	je	.L231
	cmpl	$11, -8(%rbp)
	je	.L231
	cmpl	$13, -8(%rbp)
	je	.L231
	cmpl	$18, -8(%rbp)
	je	.L231
	cmpl	$30, -8(%rbp)
	jne	.L232
.L231:
	leaq	.LC51(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L233
.L232:
	leaq	.LC39(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L233:
	addl	$1, -8(%rbp)
.L230:
	cmpl	$55, -8(%rbp)
	jle	.L234
	leaq	.LC52(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-40(%rbp), %rax
	jmp	.L203
.L207:
.L203:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.size	finddateinTree, .-finddateinTree
	.globl	deleteGlobDataBy
	.type	deleteGlobDataBy, @function
deleteGlobDataBy:
.LFB34:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.size	deleteGlobDataBy, .-deleteGlobDataBy
	.globl	readDayStructFromFile
	.type	readDayStructFromFile, @function
readDayStructFromFile:
.LFB35:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.size	readDayStructFromFile, .-readDayStructFromFile
	.globl	displayAllDayData
	.type	displayAllDayData, @function
displayAllDayData:
.LFB36:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	displayAllDayData, .-displayAllDayData
	.globl	addDayData
	.type	addDayData, @function
addDayData:
.LFB37:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.size	addDayData, .-addDayData
	.globl	changeDayStatus
	.type	changeDayStatus, @function
changeDayStatus:
.LFB38:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	showDayDataBy
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	changeDayStatus, .-changeDayStatus
	.globl	showDayDataBy
	.type	showDayDataBy, @function
showDayDataBy:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.size	showDayDataBy, .-showDayDataBy
	.globl	deleteDayDataBy
	.type	deleteDayDataBy, @function
deleteDayDataBy:
.LFB40:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	deleteDayDataBy, .-deleteDayDataBy
	.section	.rodata
.LC64:
	.string	"-g"
	.align 8
.LC65:
	.string	"error: incorrect comand line argument!\033[0m"
.LC66:
	.string	"\033[31;1m%s\t%s\n"
	.text
	.globl	globmainArgParser
	.type	globmainArgParser, @function
globmainArgParser:
.LFB41:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	readGlobStructFromFile
	movq	%rax, -24(%rbp)
	cmpl	$2, -36(%rbp)
	jne	.L256
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC64(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L256
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	displayAllGlobData
	movq	-56(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-56(%rbp), %rax
	movl	%edx, (%rax)
	jmp	.L257
.L256:
	cmpl	$2, -36(%rbp)
	jle	.L258
	cmpl	$3, -36(%rbp)
	jne	.L259
	movl	$0, -8(%rbp)
	jmp	.L260
.L263:
	movl	-8(%rbp), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdx
	leaq	flagsArrayGlob(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L261
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$103, %al
	jne	.L261
	movl	-8(%rbp), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdx
	leaq	8+flagsArrayGlob(%rip), %rax
	movq	(%rdx,%rax), %rcx
	movq	-48(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	*%rcx
	movq	%rax, -24(%rbp)
	movq	-56(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-56(%rbp), %rax
	movl	%edx, (%rax)
	jmp	.L257
.L261:
	addl	$1, -8(%rbp)
.L260:
	movl	-8(%rbp), %eax
	cmpl	$7, %eax
	jbe	.L263
	jmp	.L257
.L259:
	cmpl	$4, -36(%rbp)
	jne	.L257
	movl	$0, -4(%rbp)
	jmp	.L264
.L266:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC64(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L265
	movl	-4(%rbp), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdx
	leaq	flagsArrayGlob(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movq	-48(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L265
	movl	-4(%rbp), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdx
	leaq	8+flagsArrayGlob(%rip), %rax
	movq	(%rdx,%rax), %rcx
	movq	-48(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	*%rcx
	movq	%rax, -24(%rbp)
.L265:
	addl	$1, -4(%rbp)
.L264:
	movl	-4(%rbp), %eax
	cmpl	$7, %eax
	jbe	.L266
	jmp	.L257
.L258:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC65(%rip), %rdx
	movq	%rax, %rsi
	leaq	.LC66(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L257:
	movq	-24(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE41:
	.size	globmainArgParser, .-globmainArgParser
	.section	.rodata
.LC67:
	.string	"-l"
	.text
	.globl	daymainArgParser
	.type	daymainArgParser, @function
daymainArgParser:
.LFB42:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	readDayStructFromFile
	cmpl	$2, -36(%rbp)
	jne	.L269
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC67(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L269
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	displayAllGlobData
	movq	-56(%rbp), %rax
	addq	$4, %rax
	movq	%rax, -56(%rbp)
	jmp	.L270
.L269:
	cmpl	$2, -36(%rbp)
	jle	.L271
	cmpl	$3, -36(%rbp)
	jne	.L272
	movl	$0, -8(%rbp)
	jmp	.L273
.L277:
	movl	-8(%rbp), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdx
	leaq	flagsArrayGlob(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	je	.L274
	movl	-8(%rbp), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdx
	leaq	flagsArrayDay(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L275
.L274:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$108, %al
	jne	.L275
	movl	-8(%rbp), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdx
	leaq	8+flagsArrayDay(%rip), %rax
	movq	(%rdx,%rax), %rcx
	movq	-48(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	*%rcx
	movq	%rax, -24(%rbp)
	addq	$4, -56(%rbp)
	jmp	.L270
.L275:
	addl	$1, -8(%rbp)
.L273:
	movl	-8(%rbp), %eax
	cmpl	$7, %eax
	jbe	.L277
	jmp	.L270
.L272:
	cmpl	$4, -36(%rbp)
	jne	.L270
	movl	$0, -4(%rbp)
	jmp	.L278
.L280:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC67(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L279
	movl	-4(%rbp), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdx
	leaq	flagsArrayDay(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movq	-48(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L279
	movl	-4(%rbp), %eax
	cltq
	salq	$4, %rax
	movq	%rax, %rdx
	leaq	8+flagsArrayDay(%rip), %rax
	movq	(%rdx,%rax), %rcx
	movq	-48(%rbp), %rax
	addq	$24, %rax
	movq	(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	*%rcx
	movq	%rax, -24(%rbp)
.L279:
	addl	$1, -4(%rbp)
.L278:
	movl	-4(%rbp), %eax
	cmpl	$7, %eax
	jbe	.L280
	jmp	.L270
.L271:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC65(%rip), %rdx
	movq	%rax, %rsi
	leaq	.LC66(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L270:
	movq	-24(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE42:
	.size	daymainArgParser, .-daymainArgParser
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
