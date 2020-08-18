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
	.string	"\033[35;1m|\033[0m"
.LC21:
	.string	"\033[35;1m  |"
.LC22:
	.string	"\033[35;1m|\n\033[0m"
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
	je	.L127
	movq	-24(%rbp), %rax
	movq	48(%rax), %rax
	movl	-28(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	globTreeprint
	addl	$1, -28(%rbp)
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	printfirstFivecolumn
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%eax, -8(%rbp)
	movq	-24(%rbp), %rax
	movq	40(%rax), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%eax, -4(%rbp)
	cmpl	$35, -8(%rbp)
	jbe	.L117
	cmpl	$77, -4(%rbp)
	ja	.L117
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	printWholeHeader
	jmp	.L118
.L117:
	cmpl	$35, -8(%rbp)
	ja	.L119
	cmpl	$77, -4(%rbp)
	jbe	.L119
	movl	$0, -16(%rbp)
	jmp	.L120
.L121:
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movl	-16(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	addl	$1, -16(%rbp)
.L120:
	movl	-8(%rbp), %eax
	cmpl	%eax, -16(%rbp)
	jl	.L121
	jmp	.L122
.L123:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -16(%rbp)
.L122:
	cmpl	$34, -16(%rbp)
	jle	.L123
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	printWholeDescription
	jmp	.L118
.L119:
	cmpl	$35, -8(%rbp)
	jbe	.L124
	cmpl	$77, -4(%rbp)
	ja	.L118
.L124:
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	printHeaderandDescrp
.L118:
	leaq	.LC21(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -12(%rbp)
	jmp	.L125
.L126:
	movl	$45, %edi
	call	putchar@PLT
	addl	$1, -12(%rbp)
.L125:
	cmpl	$169, -12(%rbp)
	jle	.L126
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	56(%rax), %rax
	movl	-28(%rbp), %edx
	movl	%edx, %esi
	movq	%rax, %rdi
	call	globTreeprint
	addl	$1, -28(%rbp)
.L127:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	globTreeprint, .-globTreeprint
	.section	.rodata
.LC23:
	.string	"\033[36;1m\t\t\t\t\t\t\t\t\t\tGLOBAL TASKS"
.LC24:
	.string	"\033[35;1m   __"
.LC25:
	.string	"\033[35;1m __"
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
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	leaq	.LC12(%rip), %rdi
	call	system@PLT
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	leaq	.LC23(%rip), %rdi
	call	puts@PLT
	leaq	.LC24(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -16(%rbp)
	jmp	.L129
.L130:
	leaq	.LC25(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -16(%rbp)
.L129:
	cmpl	$55, -16(%rbp)
	jle	.L130
	movl	$10, %edi
	call	putchar@PLT
	movl	$0, -12(%rbp)
	jmp	.L131
.L134:
	cmpl	$1, -12(%rbp)
	jg	.L132
	movl	-12(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	printtopOfTable
	jmp	.L133
.L132:
	cmpl	$2, -12(%rbp)
	jne	.L133
	movl	-8(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	globTreeprint
.L133:
	addl	$1, -12(%rbp)
.L131:
	cmpl	$2, -12(%rbp)
	jle	.L134
	call	printbottomOfTable
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	displayAllGlobData, .-displayAllGlobData
	.section	.rodata
.LC26:
	.string	"\033[32mstart date: \033[0m"
.LC27:
	.string	"\033[32mfinish date: \033[0m"
.LC28:
	.string	"\033[32mdescription: \033[0m"
.LC29:
	.string	"\033[32mheader: \033[0m"
.LC30:
	.string	"\033[31mAdd more data?\033[0m"
.LC31:
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
	jmp	.L136
.L140:
	leaq	.LC26(%rip), %rdi
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
	leaq	.LC27(%rip), %rdi
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
	leaq	.LC28(%rip), %rdi
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
	jle	.L137
	leaq	.LC29(%rip), %rdi
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
.L137:
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
	je	.L138
	leaq	-10272(%rbp), %rax
	jmp	.L139
.L138:
	movq	-10352(%rbp), %rax
.L139:
	leaq	-10016(%rbp), %rcx
	leaq	-10300(%rbp), %rdx
	leaq	-10306(%rbp), %rsi
	movq	-10344(%rbp), %rdi
	leaq	.LC19(%rip), %r9
	movq	%rax, %r8
	call	createGlobalTree
	movq	%rax, -10344(%rbp)
	leaq	.LC30(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-10330(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC31(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-10329(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC31(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	addl	$1, -10328(%rbp)
.L136:
	movzbl	-10330(%rbp), %eax
	cmpb	$110, %al
	jne	.L140
	leaq	.LC12(%rip), %rdi
	call	system@PLT
	movq	-10344(%rbp), %rax
	movq	%rax, %rdi
	call	displayAllGlobData
	movq	-10344(%rbp), %rax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L142
	call	__stack_chk_fail@PLT
.L142:
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
	jmp	.L144
.L151:
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$46, %al
	je	.L145
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movl	-24(%rbp), %eax
	cltq
	movb	%dl, -13(%rbp,%rax)
	addl	$1, -24(%rbp)
	jmp	.L146
.L145:
	addl	$1, -28(%rbp)
	cmpl	$1, -28(%rbp)
	jne	.L147
	movl	-24(%rbp), %eax
	cltq
	movb	$0, -13(%rbp,%rax)
	leaq	-13(%rbp), %rax
	movq	%rax, %rdi
	call	myatoi
	movq	-40(%rbp), %rdx
	movw	%ax, 4(%rdx)
	movl	$0, -24(%rbp)
	jmp	.L146
.L147:
	cmpl	$2, -28(%rbp)
	jne	.L146
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
	jmp	.L148
.L149:
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
.L148:
	movl	-20(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jl	.L149
	movl	-24(%rbp), %eax
	cltq
	movb	$0, -13(%rbp,%rax)
	leaq	-13(%rbp), %rax
	movq	%rax, %rdi
	call	myatoi
	movq	-40(%rbp), %rdx
	movw	%ax, (%rdx)
	jmp	.L143
.L146:
	addl	$1, -20(%rbp)
.L144:
	movl	-20(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jl	.L151
.L143:
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L152
	call	__stack_chk_fail@PLT
.L152:
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
	jne	.L154
	movl	$1, -4(%rbp)
	jmp	.L156
.L154:
	movl	$0, -4(%rbp)
	jmp	.L156
.L157:
	addl	$1, -4(%rbp)
.L156:
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
	jne	.L157
	movw	$0, -6(%rbp)
	jmp	.L158
.L159:
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
.L158:
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
	jne	.L159
	movzwl	-6(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	myatoi, .-myatoi
	.section	.rodata
	.align 8
.LC32:
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
	jne	.L162
	movzwl	-22(%rbp), %eax
	movzwl	%ax, %ecx
	movzwl	-20(%rbp), %eax
	movzwl	%ax, %edx
	movzwl	-18(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC32(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L162:
	movq	-48(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	showGlobDataBy
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L164
	call	__stack_chk_fail@PLT
.L164:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	changeGlobStatus, .-changeGlobStatus
	.section	.rodata
.LC33:
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
	jne	.L166
	movl	$0, %eax
	jmp	.L165
.L166:
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	compareDates
	movl	%eax, -28(%rbp)
	cmpl	$0, -28(%rbp)
	jle	.L168
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	findstatusinTree
	jmp	.L169
.L168:
	cmpl	$0, -28(%rbp)
	jns	.L170
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	findstatusinTree
	jmp	.L169
.L170:
	leaq	.LC33(%rip), %rdi
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
	jmp	.L165
.L169:
.L165:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L171
	call	__stack_chk_fail@PLT
.L171:
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
	jne	.L173
	movzwl	-22(%rbp), %eax
	movzwl	%ax, %ecx
	movzwl	-20(%rbp), %eax
	movzwl	%ax, %edx
	movzwl	-18(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC32(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L173:
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L175
	call	__stack_chk_fail@PLT
.L175:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.size	showGlobDataBy, .-showGlobDataBy
	.section	.rodata
.LC34:
	.string	" __"
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
	jne	.L177
	movl	$0, %eax
	jmp	.L176
.L177:
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	compareDates
	movl	%eax, -16(%rbp)
	cmpl	$0, -16(%rbp)
	jle	.L179
	movq	-40(%rbp), %rax
	movq	48(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	finddateinTree
	jmp	.L180
.L179:
	cmpl	$0, -16(%rbp)
	jns	.L181
	movq	-40(%rbp), %rax
	movq	56(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	finddateinTree
	jmp	.L180
.L181:
	movl	$0, -12(%rbp)
	leaq	.LC12(%rip), %rdi
	call	system@PLT
	leaq	.LC24(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -24(%rbp)
	jmp	.L182
.L183:
	leaq	.LC34(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -24(%rbp)
.L182:
	cmpl	$55, -24(%rbp)
	jle	.L183
	movl	$10, %edi
	call	putchar@PLT
	movl	$0, -20(%rbp)
	jmp	.L184
.L190:
	cmpl	$1, -20(%rbp)
	jg	.L185
	movl	-20(%rbp), %edx
	movl	-12(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	printtopOfTable
	jmp	.L186
.L185:
	cmpl	$2, -20(%rbp)
	jne	.L186
	movq	-40(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	printfirstFivecolumn
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%eax, -8(%rbp)
	movq	-40(%rbp), %rax
	movq	40(%rax), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%eax, -4(%rbp)
	cmpl	$35, -8(%rbp)
	jbe	.L187
	cmpl	$77, -4(%rbp)
	ja	.L187
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	printWholeHeader
	jmp	.L186
.L187:
	cmpl	$35, -8(%rbp)
	ja	.L188
	cmpl	$77, -4(%rbp)
	ja	.L186
.L188:
	cmpl	$35, -8(%rbp)
	jbe	.L189
	cmpl	$77, -4(%rbp)
	ja	.L186
.L189:
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	printHeaderandDescrp
.L186:
	addl	$1, -20(%rbp)
.L184:
	cmpl	$2, -20(%rbp)
	jle	.L190
	call	printbottomOfTable
	movq	-40(%rbp), %rax
	jmp	.L176
.L180:
.L176:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.size	finddateinTree, .-finddateinTree
	.section	.rodata
.LC35:
	.string	"\033[35;1m|"
.LC36:
	.string	"|\n\033[0m"
.LC37:
	.string	"\033[35;1m  |  "
.LC38:
	.string	"|  "
.LC39:
	.string	"|\033[0m"
.LC40:
	.string	"   "
	.text
	.globl	printWholeHeader
	.type	printWholeHeader, @function
printWholeHeader:
.LFB34:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -72(%rbp)
	movl	%esi, -76(%rbp)
	movl	%edx, -80(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -40(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	$0, -52(%rbp)
	jmp	.L192
.L222:
	movl	-76(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-52(%rbp), %eax
	cmpl	%eax, %edx
	jne	.L193
	movl	-56(%rbp), %eax
	cmpl	$35, %eax
	ja	.L193
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rdx
	movl	-52(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	$0, -36(%rbp)
	jmp	.L194
.L195:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -36(%rbp)
.L194:
	movl	-56(%rbp), %eax
	movl	$35, %edx
	subl	%eax, %edx
	movl	-36(%rbp), %eax
	cmpl	%eax, %edx
	ja	.L195
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -32(%rbp)
	jmp	.L196
.L197:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -32(%rbp)
.L196:
	cmpl	$76, -32(%rbp)
	jle	.L197
	leaq	.LC36(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L198
.L193:
	movl	-56(%rbp), %eax
	cmpl	$20, %eax
	jbe	.L199
	movq	-72(%rbp), %rax
	movq	(%rax), %rdx
	movl	-52(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L200
	movq	-72(%rbp), %rax
	movq	(%rax), %rdx
	movl	-52(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$44, %al
	je	.L200
	movq	-72(%rbp), %rax
	movq	(%rax), %rdx
	movl	-52(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$46, %al
	je	.L200
	movq	-72(%rbp), %rax
	movq	(%rax), %rdx
	movl	-52(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$33, %al
	je	.L200
	movq	-72(%rbp), %rax
	movq	(%rax), %rdx
	movl	-52(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$63, %al
	je	.L200
	movq	-72(%rbp), %rax
	movq	(%rax), %rdx
	movl	-52(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$45, %al
	jne	.L199
.L200:
	movl	-52(%rbp), %eax
	movl	%eax, -48(%rbp)
	leaq	-48(%rbp), %rdi
	leaq	-52(%rbp), %rcx
	leaq	-56(%rbp), %rdx
	movl	-76(%rbp), %esi
	movq	-72(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	printHeader
	cmpl	$0, -40(%rbp)
	jne	.L201
	movl	$1, -40(%rbp)
	movl	$0, -24(%rbp)
	jmp	.L202
.L203:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -24(%rbp)
.L202:
	movl	-56(%rbp), %eax
	movl	$35, %edx
	subl	%eax, %edx
	movl	-24(%rbp), %eax
	cmpl	%eax, %edx
	ja	.L203
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -28(%rbp)
	jmp	.L204
.L205:
	movq	-72(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-28(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	addl	$1, -28(%rbp)
.L204:
	movl	-28(%rbp), %eax
	cmpl	%eax, -80(%rbp)
	ja	.L205
	jmp	.L206
.L207:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -28(%rbp)
.L206:
	cmpl	$76, -28(%rbp)
	jle	.L207
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L208
.L201:
	movl	$0, -20(%rbp)
	jmp	.L209
.L210:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -20(%rbp)
.L209:
	movl	-56(%rbp), %eax
	movl	$35, %edx
	subl	%eax, %edx
	movl	-20(%rbp), %eax
	cmpl	%eax, %edx
	ja	.L210
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -16(%rbp)
	jmp	.L211
.L212:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -16(%rbp)
.L211:
	cmpl	$76, -16(%rbp)
	jle	.L212
	leaq	.LC36(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L208:
	movl	$1, -44(%rbp)
	movl	$0, -56(%rbp)
	jmp	.L213
.L199:
	cmpl	$0, -44(%rbp)
	je	.L214
	leaq	.LC37(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -12(%rbp)
	jmp	.L215
.L221:
	cmpl	$1, -12(%rbp)
	je	.L216
	cmpl	$6, -12(%rbp)
	je	.L216
	cmpl	$11, -12(%rbp)
	je	.L216
	cmpl	$13, -12(%rbp)
	jne	.L217
.L216:
	leaq	.LC38(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L218
.L217:
	cmpl	$18, -12(%rbp)
	jne	.L219
	leaq	.LC39(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L220
.L219:
	leaq	.LC40(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L218:
	addl	$1, -12(%rbp)
.L215:
	cmpl	$55, -12(%rbp)
	jle	.L221
.L220:
	movl	$0, -44(%rbp)
.L214:
	movq	-72(%rbp), %rax
	movq	(%rax), %rdx
	movl	-52(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	-56(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -56(%rbp)
.L213:
	movl	-52(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -52(%rbp)
.L192:
	movl	-52(%rbp), %eax
	cmpl	%eax, -76(%rbp)
	ja	.L222
.L198:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L223
	call	__stack_chk_fail@PLT
.L223:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.size	printWholeHeader, .-printWholeHeader
	.globl	printHeader
	.type	printHeader, @function
printHeader:
.LFB35:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	jmp	.L225
.L234:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jne	.L226
	jmp	.L227
.L228:
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-32(%rbp), %rax
	movl	%edx, (%rax)
.L227:
	movq	-40(%rbp), %rax
	movl	(%rax), %edx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jge	.L228
	jmp	.L229
.L226:
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L232
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$44, %al
	je	.L232
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$46, %al
	je	.L232
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$63, %al
	je	.L232
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$33, %al
	je	.L232
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$45, %al
	jne	.L231
	jmp	.L232
.L233:
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-32(%rbp), %rax
	movl	%edx, (%rax)
.L232:
	movq	-32(%rbp), %rax
	movl	(%rax), %edx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jl	.L233
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
	movq	-40(%rbp), %rdi
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	printHeader
	jmp	.L229
.L231:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
.L225:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -12(%rbp)
	jbe	.L235
	movq	-40(%rbp), %rax
	movl	(%rax), %edx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	$35, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	cmpl	%eax, %edx
	jb	.L234
	jmp	.L235
.L229:
.L235:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.size	printHeader, .-printHeader
	.globl	printWholeDescription
	.type	printWholeDescription, @function
printWholeDescription:
.LFB36:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -56(%rbp)
	movl	%esi, -60(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -24(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	$0, -32(%rbp)
	jmp	.L237
.L255:
	movl	-60(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-32(%rbp), %eax
	cmpl	%eax, %edx
	jne	.L238
	movl	-36(%rbp), %eax
	cmpl	$77, %eax
	ja	.L238
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	movq	-56(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-32(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	$0, -20(%rbp)
	jmp	.L239
.L240:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -20(%rbp)
.L239:
	movl	-36(%rbp), %eax
	movl	$77, %edx
	subl	%eax, %edx
	movl	-20(%rbp), %eax
	cmpl	%eax, %edx
	ja	.L240
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L241
.L238:
	movl	-36(%rbp), %eax
	cmpl	$60, %eax
	jbe	.L242
	movq	-56(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-32(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L243
	movq	-56(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-32(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$44, %al
	je	.L243
	movq	-56(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-32(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$46, %al
	je	.L243
	movq	-56(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-32(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$33, %al
	je	.L243
	movq	-56(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-32(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$63, %al
	je	.L243
	movq	-56(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-32(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$45, %al
	jne	.L242
.L243:
	movl	-32(%rbp), %eax
	movl	%eax, -28(%rbp)
	leaq	-28(%rbp), %rdi
	leaq	-32(%rbp), %rcx
	leaq	-36(%rbp), %rdx
	movl	-60(%rbp), %esi
	movq	-56(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	printDescription
	movl	$0, -16(%rbp)
	jmp	.L244
.L245:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -16(%rbp)
.L244:
	movl	-36(%rbp), %eax
	movl	$77, %edx
	subl	%eax, %edx
	movl	-16(%rbp), %eax
	cmpl	%eax, %edx
	ja	.L245
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, -24(%rbp)
	movl	$0, -36(%rbp)
	jmp	.L246
.L242:
	cmpl	$0, -24(%rbp)
	je	.L247
	leaq	.LC37(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -12(%rbp)
	jmp	.L248
.L254:
	cmpl	$1, -12(%rbp)
	je	.L249
	cmpl	$6, -12(%rbp)
	je	.L249
	cmpl	$11, -12(%rbp)
	je	.L249
	cmpl	$13, -12(%rbp)
	je	.L249
	cmpl	$18, -12(%rbp)
	jne	.L250
.L249:
	leaq	.LC38(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L251
.L250:
	cmpl	$30, -12(%rbp)
	jne	.L252
	leaq	.LC39(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L253
.L252:
	leaq	.LC40(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L251:
	addl	$1, -12(%rbp)
.L248:
	cmpl	$55, -12(%rbp)
	jle	.L254
.L253:
	movl	$0, -24(%rbp)
.L247:
	movq	-56(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-32(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
.L246:
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
.L237:
	movl	-32(%rbp), %eax
	cmpl	%eax, -60(%rbp)
	ja	.L255
.L241:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L256
	call	__stack_chk_fail@PLT
.L256:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	printWholeDescription, .-printWholeDescription
	.globl	printDescription
	.type	printDescription, @function
printDescription:
.LFB37:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8, -40(%rbp)
	jmp	.L258
.L267:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, %edx
	jne	.L259
	jmp	.L260
.L261:
	movq	-8(%rbp), %rax
	movq	40(%rax), %rdx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-32(%rbp), %rax
	movl	%edx, (%rax)
.L260:
	movq	-40(%rbp), %rax
	movl	(%rax), %edx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jge	.L261
	jmp	.L262
.L259:
	movq	-8(%rbp), %rax
	movq	40(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L265
	movq	-8(%rbp), %rax
	movq	40(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$44, %al
	je	.L265
	movq	-8(%rbp), %rax
	movq	40(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$46, %al
	je	.L265
	movq	-8(%rbp), %rax
	movq	40(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$63, %al
	je	.L265
	movq	-8(%rbp), %rax
	movq	40(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$33, %al
	je	.L265
	movq	-8(%rbp), %rax
	movq	40(%rax), %rdx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$45, %al
	jne	.L264
	jmp	.L265
.L266:
	movq	-8(%rbp), %rax
	movq	40(%rax), %rdx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-32(%rbp), %rax
	movl	%edx, (%rax)
.L265:
	movq	-32(%rbp), %rax
	movl	(%rax), %edx
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, %edx
	jl	.L266
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
	movq	-40(%rbp), %rdi
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	printDescription
	jmp	.L262
.L264:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-40(%rbp), %rax
	movl	%edx, (%rax)
.L258:
	movq	-40(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -12(%rbp)
	jbe	.L268
	movq	-40(%rbp), %rax
	movl	(%rax), %edx
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	$77, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	cmpl	%eax, %edx
	jb	.L267
	jmp	.L268
.L262:
.L268:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.size	printDescription, .-printDescription
	.section	.rodata
.LC41:
	.string	"\033[36;1m%5d\033[0m"
.LC42:
	.string	"  %d."
.LC43:
	.string	"  0%d."
.LC44:
	.string	"%d."
.LC45:
	.string	"0%d."
.LC46:
	.string	"%d  "
.LC47:
	.string	"%5d"
.LC48:
	.string	"\033[33;1m %s  "
.LC49:
	.string	"done"
.LC50:
	.string	"\033[32m     %s     "
.LC51:
	.string	"denied"
.LC52:
	.string	"\033[31m    %s    "
	.text
	.globl	printfirstFivecolumn
	.type	printfirstFivecolumn, @function
printfirstFivecolumn:
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
	movl	%esi, -12(%rbp)
	leaq	.LC21(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC41(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	4(%rax), %eax
	cmpw	$9, %ax
	jbe	.L270
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L271
.L270:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC43(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L271:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	2(%rax), %eax
	cmpw	$9, %ax
	jbe	.L272
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC44(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L273
.L272:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC45(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L273:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC46(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	4(%rax), %eax
	cmpw	$9, %ax
	jbe	.L274
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC42(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L275
.L274:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	4(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC43(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L275:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	2(%rax), %eax
	cmpw	$9, %ax
	jbe	.L276
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC44(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L277
.L276:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC45(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L277:
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC46(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	movl	%eax, %esi
	leaq	.LC47(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movq	32(%rax), %rax
	leaq	.LC19(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L278
	movq	-8(%rbp), %rax
	movq	32(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC48(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L279
.L278:
	movq	-8(%rbp), %rax
	movq	32(%rax), %rax
	leaq	.LC49(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L280
	movq	-8(%rbp), %rax
	movq	32(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC50(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L279
.L280:
	movq	-8(%rbp), %rax
	movq	32(%rax), %rax
	leaq	.LC51(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L279
	movq	-8(%rbp), %rax
	movq	32(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC52(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L279:
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	printfirstFivecolumn, .-printfirstFivecolumn
	.section	.rodata
.LC53:
	.string	"\033[34m  \342\204\226  \033[0m"
.LC54:
	.string	"\033[35;1m-"
.LC55:
	.string	"\033[34m  start date  "
.LC56:
	.string	"\033[34m  finish date "
.LC57:
	.string	"\033[34m day "
.LC58:
	.string	"\033[34m    status   "
.LC59:
	.string	"\033[34m\t\t task name\t       "
.LC60:
	.string	"\033[34m\t\t\t\tdescription\t\t\t\t    "
.LC61:
	.string	"\033[35;1m "
	.text
	.globl	printtopOfTable
	.type	printtopOfTable, @function
printtopOfTable:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	leaq	.LC21(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -24(%rbp)
	jne	.L282
	leaq	.LC53(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$5, -20(%rbp)
.L282:
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L283
.L292:
	cmpl	$1, -24(%rbp)
	jne	.L284
	leaq	.LC54(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L285
.L284:
	cmpl	$5, -4(%rbp)
	jne	.L286
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -24(%rbp)
	jne	.L285
	leaq	.LC55(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$19, -4(%rbp)
	jmp	.L285
.L286:
	cmpl	$20, -4(%rbp)
	jne	.L287
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -24(%rbp)
	jne	.L285
	leaq	.LC56(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$34, -4(%rbp)
	jmp	.L285
.L287:
	cmpl	$35, -4(%rbp)
	jne	.L288
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -24(%rbp)
	jne	.L285
	leaq	.LC57(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$40, -4(%rbp)
	jmp	.L285
.L288:
	cmpl	$41, -4(%rbp)
	jne	.L289
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -24(%rbp)
	jne	.L285
	leaq	.LC58(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$54, -4(%rbp)
	jmp	.L285
.L289:
	cmpl	$56, -4(%rbp)
	jne	.L290
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -24(%rbp)
	jne	.L285
	leaq	.LC59(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$91, -4(%rbp)
	jmp	.L285
.L290:
	cmpl	$92, -4(%rbp)
	jne	.L291
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	cmpl	$0, -24(%rbp)
	jne	.L285
	leaq	.LC60(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$168, -4(%rbp)
	jmp	.L285
.L291:
	leaq	.LC61(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L285:
	addl	$1, -4(%rbp)
.L283:
	cmpl	$169, -4(%rbp)
	jle	.L292
	leaq	.LC35(%rip), %rdi
	call	puts@PLT
	movl	$0, -20(%rbp)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.size	printtopOfTable, .-printtopOfTable
	.section	.rodata
.LC62:
	.string	"\033[35;1m  |__"
.LC63:
	.string	"|__"
.LC64:
	.string	"|\n\n\033[0m"
	.text
	.globl	printbottomOfTable
	.type	printbottomOfTable, @function
printbottomOfTable:
.LFB40:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	leaq	.LC62(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -4(%rbp)
	jmp	.L294
.L302:
	cmpl	$1, -4(%rbp)
	jne	.L295
	leaq	.LC63(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L296
.L295:
	cmpl	$6, -4(%rbp)
	jne	.L297
	leaq	.LC63(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L296
.L297:
	cmpl	$11, -4(%rbp)
	jne	.L298
	leaq	.LC63(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L296
.L298:
	cmpl	$13, -4(%rbp)
	jne	.L299
	leaq	.LC63(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L296
.L299:
	cmpl	$18, -4(%rbp)
	jne	.L300
	leaq	.LC63(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L296
.L300:
	cmpl	$30, -4(%rbp)
	jne	.L301
	leaq	.LC63(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L296
.L301:
	leaq	.LC25(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L296:
	addl	$1, -4(%rbp)
.L294:
	cmpl	$55, -4(%rbp)
	jle	.L302
	leaq	.LC64(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	printbottomOfTable, .-printbottomOfTable
	.globl	printHeaderandDescrp
	.type	printHeaderandDescrp, @function
printHeaderandDescrp:
.LFB41:
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
	movl	%edx, -32(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L304
.L305:
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movl	-8(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	addl	$1, -8(%rbp)
.L304:
	movl	-28(%rbp), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L305
	jmp	.L306
.L307:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -8(%rbp)
.L306:
	cmpl	$34, -8(%rbp)
	jle	.L307
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -4(%rbp)
	jmp	.L308
.L309:
	movq	-24(%rbp), %rax
	movq	40(%rax), %rdx
	movl	-4(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	addl	$1, -4(%rbp)
.L308:
	movl	-32(%rbp), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L309
	jmp	.L310
.L311:
	movl	$32, %edi
	call	putchar@PLT
	addl	$1, -4(%rbp)
.L310:
	cmpl	$76, -4(%rbp)
	jle	.L311
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE41:
	.size	printHeaderandDescrp, .-printHeaderandDescrp
	.globl	deleteGlobDataBy
	.type	deleteGlobDataBy, @function
deleteGlobDataBy:
.LFB42:
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
.LFE42:
	.size	deleteGlobDataBy, .-deleteGlobDataBy
	.globl	readDayStructFromFile
	.type	readDayStructFromFile, @function
readDayStructFromFile:
.LFB43:
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
.LFE43:
	.size	readDayStructFromFile, .-readDayStructFromFile
	.globl	displayAllDayData
	.type	displayAllDayData, @function
displayAllDayData:
.LFB44:
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
.LFE44:
	.size	displayAllDayData, .-displayAllDayData
	.globl	addDayData
	.type	addDayData, @function
addDayData:
.LFB45:
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
.LFE45:
	.size	addDayData, .-addDayData
	.globl	changeDayStatus
	.type	changeDayStatus, @function
changeDayStatus:
.LFB46:
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
.LFE46:
	.size	changeDayStatus, .-changeDayStatus
	.globl	showDayDataBy
	.type	showDayDataBy, @function
showDayDataBy:
.LFB47:
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
.LFE47:
	.size	showDayDataBy, .-showDayDataBy
	.globl	deleteDayDataBy
	.type	deleteDayDataBy, @function
deleteDayDataBy:
.LFB48:
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
.LFE48:
	.size	deleteDayDataBy, .-deleteDayDataBy
	.section	.rodata
.LC65:
	.string	"-g"
	.align 8
.LC66:
	.string	"error: incorrect comand line argument!\033[0m"
.LC67:
	.string	"\033[31;1m%s\t%s\n"
	.text
	.globl	globmainArgParser
	.type	globmainArgParser, @function
globmainArgParser:
.LFB49:
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
	jne	.L327
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC65(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L327
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	displayAllGlobData
	movq	-56(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movq	-56(%rbp), %rax
	movl	%edx, (%rax)
	jmp	.L328
.L327:
	cmpl	$2, -36(%rbp)
	jle	.L329
	cmpl	$3, -36(%rbp)
	jne	.L330
	movl	$0, -8(%rbp)
	jmp	.L331
.L334:
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
	jne	.L332
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$103, %al
	jne	.L332
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
	jmp	.L328
.L332:
	addl	$1, -8(%rbp)
.L331:
	movl	-8(%rbp), %eax
	cmpl	$7, %eax
	jbe	.L334
	jmp	.L328
.L330:
	cmpl	$4, -36(%rbp)
	jne	.L328
	movl	$0, -4(%rbp)
	jmp	.L335
.L337:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC65(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L336
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
	jne	.L336
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
.L336:
	addl	$1, -4(%rbp)
.L335:
	movl	-4(%rbp), %eax
	cmpl	$7, %eax
	jbe	.L337
	jmp	.L328
.L329:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC66(%rip), %rdx
	movq	%rax, %rsi
	leaq	.LC67(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L328:
	movq	-24(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE49:
	.size	globmainArgParser, .-globmainArgParser
	.section	.rodata
.LC68:
	.string	"-l"
	.text
	.globl	daymainArgParser
	.type	daymainArgParser, @function
daymainArgParser:
.LFB50:
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
	jne	.L340
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC68(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L340
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	displayAllGlobData
	movq	-56(%rbp), %rax
	addq	$4, %rax
	movq	%rax, -56(%rbp)
	jmp	.L341
.L340:
	cmpl	$2, -36(%rbp)
	jle	.L342
	cmpl	$3, -36(%rbp)
	jne	.L343
	movl	$0, -8(%rbp)
	jmp	.L344
.L348:
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
	je	.L345
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
	jne	.L346
.L345:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$108, %al
	jne	.L346
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
	jmp	.L341
.L346:
	addl	$1, -8(%rbp)
.L344:
	movl	-8(%rbp), %eax
	cmpl	$7, %eax
	jbe	.L348
	jmp	.L341
.L343:
	cmpl	$4, -36(%rbp)
	jne	.L341
	movl	$0, -4(%rbp)
	jmp	.L349
.L351:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC68(%rip), %rsi
	movq	%rax, %rdi
	call	mystrcmp
	testl	%eax, %eax
	jne	.L350
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
	jne	.L350
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
.L350:
	addl	$1, -4(%rbp)
.L349:
	movl	-4(%rbp), %eax
	cmpl	$7, %eax
	jbe	.L351
	jmp	.L341
.L342:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC66(%rip), %rdx
	movq	%rax, %rsi
	leaq	.LC67(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L341:
	movq	-24(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE50:
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
