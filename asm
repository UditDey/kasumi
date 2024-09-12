
kernel/target/target/release/kernel:     file format elf64-x86-64


Disassembly of section .text:

ffffffff80000000 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E>:
ffffffff80000000:	48 81 ec 88 00 00 00 	sub    rsp,0x88
ffffffff80000007:	8b 46 34             	mov    eax,DWORD PTR [rsi+0x34]
ffffffff8000000a:	a8 10                	test   al,0x10
ffffffff8000000c:	0f 85 de 00 00 00    	jne    ffffffff800000f0 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0xf0>
ffffffff80000012:	a8 20                	test   al,0x20
ffffffff80000014:	0f 85 1b 01 00 00    	jne    ffffffff80000135 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0x135>
ffffffff8000001a:	8b 17                	mov    edx,DWORD PTR [rdi]
ffffffff8000001c:	41 b9 27 00 00 00    	mov    r9d,0x27
ffffffff80000022:	48 8d 05 51 64 00 00 	lea    rax,[rip+0x6451]        # ffffffff8000647a <memset+0x2c9a>
ffffffff80000029:	48 81 fa 10 27 00 00 	cmp    rdx,0x2710
ffffffff80000030:	0f 82 7a 01 00 00    	jb     ffffffff800001b0 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0x1b0>
ffffffff80000036:	41 b8 27 00 00 00    	mov    r8d,0x27
ffffffff8000003c:	48 bf 4b 59 86 38 d6 	movabs rdi,0x346dc5d63886594b
ffffffff80000043:	c5 6d 34 
ffffffff80000046:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
ffffffff8000004d:	00 00 00 
ffffffff80000050:	c4 e2 f3 f6 cf       	mulx   rcx,rcx,rdi
ffffffff80000055:	48 c1 e9 0b          	shr    rcx,0xb
ffffffff80000059:	44 69 c9 10 27 00 00 	imul   r9d,ecx,0x2710
ffffffff80000060:	41 89 d2             	mov    r10d,edx
ffffffff80000063:	45 29 ca             	sub    r10d,r9d
ffffffff80000066:	45 69 da 7b 14 00 00 	imul   r11d,r10d,0x147b
ffffffff8000006d:	41 c1 eb 13          	shr    r11d,0x13
ffffffff80000071:	45 6b cb 64          	imul   r9d,r11d,0x64
ffffffff80000075:	45 29 ca             	sub    r10d,r9d
ffffffff80000078:	45 0f b7 d2          	movzx  r10d,r10w
ffffffff8000007c:	4d 8d 48 fc          	lea    r9,[r8-0x4]
ffffffff80000080:	46 0f b7 1c 58       	movzx  r11d,WORD PTR [rax+r11*2]
ffffffff80000085:	66 46 89 5c 04 04    	mov    WORD PTR [rsp+r8*1+0x4],r11w
ffffffff8000008b:	46 0f b7 14 50       	movzx  r10d,WORD PTR [rax+r10*2]
ffffffff80000090:	66 46 89 54 04 06    	mov    WORD PTR [rsp+r8*1+0x6],r10w
ffffffff80000096:	4d 89 c8             	mov    r8,r9
ffffffff80000099:	48 81 fa ff e0 f5 05 	cmp    rdx,0x5f5e0ff
ffffffff800000a0:	48 89 ca             	mov    rdx,rcx
ffffffff800000a3:	77 ab                	ja     ffffffff80000050 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0x50>
ffffffff800000a5:	48 83 f9 63          	cmp    rcx,0x63
ffffffff800000a9:	76 28                	jbe    ffffffff800000d3 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0xd3>
ffffffff800000ab:	0f b7 d1             	movzx  edx,cx
ffffffff800000ae:	c1 ea 02             	shr    edx,0x2
ffffffff800000b1:	69 d2 7b 14 00 00    	imul   edx,edx,0x147b
ffffffff800000b7:	c1 ea 11             	shr    edx,0x11
ffffffff800000ba:	6b fa 64             	imul   edi,edx,0x64
ffffffff800000bd:	29 f9                	sub    ecx,edi
ffffffff800000bf:	0f b7 c9             	movzx  ecx,cx
ffffffff800000c2:	0f b7 0c 48          	movzx  ecx,WORD PTR [rax+rcx*2]
ffffffff800000c6:	66 42 89 4c 0c 06    	mov    WORD PTR [rsp+r9*1+0x6],cx
ffffffff800000cc:	49 83 c1 fe          	add    r9,0xfffffffffffffffe
ffffffff800000d0:	48 89 d1             	mov    rcx,rdx
ffffffff800000d3:	48 89 f7             	mov    rdi,rsi
ffffffff800000d6:	48 83 f9 0a          	cmp    rcx,0xa
ffffffff800000da:	0f 83 e2 00 00 00    	jae    ffffffff800001c2 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0x1c2>
ffffffff800000e0:	80 c9 30             	or     cl,0x30
ffffffff800000e3:	42 88 4c 0c 07       	mov    BYTE PTR [rsp+r9*1+0x7],cl
ffffffff800000e8:	49 ff c9             	dec    r9
ffffffff800000eb:	e9 e0 00 00 00       	jmp    ffffffff800001d0 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0x1d0>
ffffffff800000f0:	8b 0f                	mov    ecx,DWORD PTR [rdi]
ffffffff800000f2:	b8 81 00 00 00       	mov    eax,0x81
ffffffff800000f7:	89 ca                	mov    edx,ecx
ffffffff800000f9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
ffffffff80000100:	c1 ea 04             	shr    edx,0x4
ffffffff80000103:	89 cf                	mov    edi,ecx
ffffffff80000105:	40 80 e7 0f          	and    dil,0xf
ffffffff80000109:	44 8d 47 30          	lea    r8d,[rdi+0x30]
ffffffff8000010d:	44 8d 4f 57          	lea    r9d,[rdi+0x57]
ffffffff80000111:	40 80 ff 0a          	cmp    dil,0xa
ffffffff80000115:	41 0f b6 f8          	movzx  edi,r8b
ffffffff80000119:	45 0f b6 c1          	movzx  r8d,r9b
ffffffff8000011d:	44 0f 42 c7          	cmovb  r8d,edi
ffffffff80000121:	48 89 c7             	mov    rdi,rax
ffffffff80000124:	44 88 44 04 06       	mov    BYTE PTR [rsp+rax*1+0x6],r8b
ffffffff80000129:	48 ff c8             	dec    rax
ffffffff8000012c:	83 f9 10             	cmp    ecx,0x10
ffffffff8000012f:	89 d1                	mov    ecx,edx
ffffffff80000131:	73 cd                	jae    ffffffff80000100 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0x100>
ffffffff80000133:	eb 3e                	jmp    ffffffff80000173 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0x173>
ffffffff80000135:	8b 0f                	mov    ecx,DWORD PTR [rdi]
ffffffff80000137:	b8 81 00 00 00       	mov    eax,0x81
ffffffff8000013c:	89 ca                	mov    edx,ecx
ffffffff8000013e:	66 90                	xchg   ax,ax
ffffffff80000140:	c1 ea 04             	shr    edx,0x4
ffffffff80000143:	89 cf                	mov    edi,ecx
ffffffff80000145:	40 80 e7 0f          	and    dil,0xf
ffffffff80000149:	44 8d 47 30          	lea    r8d,[rdi+0x30]
ffffffff8000014d:	44 8d 4f 37          	lea    r9d,[rdi+0x37]
ffffffff80000151:	40 80 ff 0a          	cmp    dil,0xa
ffffffff80000155:	41 0f b6 f8          	movzx  edi,r8b
ffffffff80000159:	45 0f b6 c1          	movzx  r8d,r9b
ffffffff8000015d:	44 0f 42 c7          	cmovb  r8d,edi
ffffffff80000161:	48 89 c7             	mov    rdi,rax
ffffffff80000164:	44 88 44 04 06       	mov    BYTE PTR [rsp+rax*1+0x6],r8b
ffffffff80000169:	48 ff c8             	dec    rax
ffffffff8000016c:	83 f9 10             	cmp    ecx,0x10
ffffffff8000016f:	89 d1                	mov    ecx,edx
ffffffff80000171:	73 cd                	jae    ffffffff80000140 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0x140>
ffffffff80000173:	48 83 c7 fe          	add    rdi,0xfffffffffffffffe
ffffffff80000177:	48 81 ff 80 00 00 00 	cmp    rdi,0x80
ffffffff8000017e:	77 75                	ja     ffffffff800001f5 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0x1f5>
ffffffff80000180:	41 b8 81 00 00 00    	mov    r8d,0x81
ffffffff80000186:	49 29 c0             	sub    r8,rax
ffffffff80000189:	48 8d 0c 3c          	lea    rcx,[rsp+rdi*1]
ffffffff8000018d:	48 83 c1 08          	add    rcx,0x8
ffffffff80000191:	48 8d 05 e0 62 00 00 	lea    rax,[rip+0x62e0]        # ffffffff80006478 <memset+0x2c98>
ffffffff80000198:	ba 02 00 00 00       	mov    edx,0x2
ffffffff8000019d:	48 89 f7             	mov    rdi,rsi
ffffffff800001a0:	48 89 c6             	mov    rsi,rax
ffffffff800001a3:	e8 38 22 00 00       	call   ffffffff800023e0 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E>
ffffffff800001a8:	48 81 c4 88 00 00 00 	add    rsp,0x88
ffffffff800001af:	c3                   	ret    
ffffffff800001b0:	48 89 d1             	mov    rcx,rdx
ffffffff800001b3:	48 83 f9 63          	cmp    rcx,0x63
ffffffff800001b7:	0f 87 ee fe ff ff    	ja     ffffffff800000ab <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0xab>
ffffffff800001bd:	e9 11 ff ff ff       	jmp    ffffffff800000d3 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E+0xd3>
ffffffff800001c2:	0f b7 04 48          	movzx  eax,WORD PTR [rax+rcx*2]
ffffffff800001c6:	66 42 89 44 0c 06    	mov    WORD PTR [rsp+r9*1+0x6],ax
ffffffff800001cc:	49 83 c1 fe          	add    r9,0xfffffffffffffffe
ffffffff800001d0:	4a 8d 0c 0c          	lea    rcx,[rsp+r9*1]
ffffffff800001d4:	48 83 c1 08          	add    rcx,0x8
ffffffff800001d8:	41 b8 27 00 00 00    	mov    r8d,0x27
ffffffff800001de:	4d 29 c8             	sub    r8,r9
ffffffff800001e1:	be 01 00 00 00       	mov    esi,0x1
ffffffff800001e6:	31 d2                	xor    edx,edx
ffffffff800001e8:	e8 f3 21 00 00       	call   ffffffff800023e0 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E>
ffffffff800001ed:	48 81 c4 88 00 00 00 	add    rsp,0x88
ffffffff800001f4:	c3                   	ret    
ffffffff800001f5:	e8 c6 1f 00 00       	call   ffffffff800021c0 <_ZN4core5slice5index26slice_start_index_len_fail17he0c8b7fd2d8ebd25E>
ffffffff800001fa:	cc                   	int3   
ffffffff800001fb:	cc                   	int3   
ffffffff800001fc:	cc                   	int3   
ffffffff800001fd:	cc                   	int3   
ffffffff800001fe:	cc                   	int3   
ffffffff800001ff:	cc                   	int3   

ffffffff80000200 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf9e1b85a2cf7a76dE>:
ffffffff80000200:	48 83 ec 68          	sub    rsp,0x68
ffffffff80000204:	48 8b 07             	mov    rax,QWORD PTR [rdi]
ffffffff80000207:	48 8d 48 10          	lea    rcx,[rax+0x10]
ffffffff8000020b:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
ffffffff80000210:	48 83 c0 14          	add    rax,0x14
ffffffff80000214:	48 8d 15 75 2c 00 00 	lea    rdx,[rip+0x2c75]        # ffffffff80002e90 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h5edd5340cb38599eE>
ffffffff8000021b:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
ffffffff80000220:	48 89 4c 24 18       	mov    QWORD PTR [rsp+0x18],rcx
ffffffff80000225:	48 8d 0d a4 2e 00 00 	lea    rcx,[rip+0x2ea4]        # ffffffff800030d0 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E>
ffffffff8000022c:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
ffffffff80000231:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
ffffffff80000236:	48 89 4c 24 30       	mov    QWORD PTR [rsp+0x30],rcx
ffffffff8000023b:	48 8d 05 4e 5f 01 00 	lea    rax,[rip+0x15f4e]        # ffffffff80016190 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0xb0>
ffffffff80000242:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
ffffffff80000247:	48 c7 44 24 40 03 00 	mov    QWORD PTR [rsp+0x40],0x3
ffffffff8000024e:	00 00 
ffffffff80000250:	48 c7 44 24 58 00 00 	mov    QWORD PTR [rsp+0x58],0x0
ffffffff80000257:	00 00 
ffffffff80000259:	48 8d 44 24 08       	lea    rax,[rsp+0x8]
ffffffff8000025e:	48 89 44 24 48       	mov    QWORD PTR [rsp+0x48],rax
ffffffff80000263:	48 c7 44 24 50 03 00 	mov    QWORD PTR [rsp+0x50],0x3
ffffffff8000026a:	00 00 
ffffffff8000026c:	48 8b 7e 20          	mov    rdi,QWORD PTR [rsi+0x20]
ffffffff80000270:	48 8b 76 28          	mov    rsi,QWORD PTR [rsi+0x28]
ffffffff80000274:	48 8d 54 24 38       	lea    rdx,[rsp+0x38]
ffffffff80000279:	e8 32 2c 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff8000027e:	48 83 c4 68          	add    rsp,0x68
ffffffff80000282:	c3                   	ret    
ffffffff80000283:	cc                   	int3   
ffffffff80000284:	cc                   	int3   
ffffffff80000285:	cc                   	int3   
ffffffff80000286:	cc                   	int3   
ffffffff80000287:	cc                   	int3   
ffffffff80000288:	cc                   	int3   
ffffffff80000289:	cc                   	int3   
ffffffff8000028a:	cc                   	int3   
ffffffff8000028b:	cc                   	int3   
ffffffff8000028c:	cc                   	int3   
ffffffff8000028d:	cc                   	int3   
ffffffff8000028e:	cc                   	int3   
ffffffff8000028f:	cc                   	int3   

ffffffff80000290 <_ZN4core3fmt5Write10write_char17h40221af7d4326731E>:
ffffffff80000290:	50                   	push   rax
ffffffff80000291:	c7 44 24 04 00 00 00 	mov    DWORD PTR [rsp+0x4],0x0
ffffffff80000298:	00 
ffffffff80000299:	81 fe 80 00 00 00    	cmp    esi,0x80
ffffffff8000029f:	73 0f                	jae    ffffffff800002b0 <_ZN4core3fmt5Write10write_char17h40221af7d4326731E+0x20>
ffffffff800002a1:	40 88 74 24 04       	mov    BYTE PTR [rsp+0x4],sil
ffffffff800002a6:	ba 01 00 00 00       	mov    edx,0x1
ffffffff800002ab:	e9 90 00 00 00       	jmp    ffffffff80000340 <_ZN4core3fmt5Write10write_char17h40221af7d4326731E+0xb0>
ffffffff800002b0:	89 f0                	mov    eax,esi
ffffffff800002b2:	81 fe 00 08 00 00    	cmp    esi,0x800
ffffffff800002b8:	73 1d                	jae    ffffffff800002d7 <_ZN4core3fmt5Write10write_char17h40221af7d4326731E+0x47>
ffffffff800002ba:	c1 e8 06             	shr    eax,0x6
ffffffff800002bd:	0c c0                	or     al,0xc0
ffffffff800002bf:	88 44 24 04          	mov    BYTE PTR [rsp+0x4],al
ffffffff800002c3:	40 80 e6 3f          	and    sil,0x3f
ffffffff800002c7:	40 80 ce 80          	or     sil,0x80
ffffffff800002cb:	40 88 74 24 05       	mov    BYTE PTR [rsp+0x5],sil
ffffffff800002d0:	ba 02 00 00 00       	mov    edx,0x2
ffffffff800002d5:	eb 69                	jmp    ffffffff80000340 <_ZN4core3fmt5Write10write_char17h40221af7d4326731E+0xb0>
ffffffff800002d7:	81 fe 00 00 01 00    	cmp    esi,0x10000
ffffffff800002dd:	73 2a                	jae    ffffffff80000309 <_ZN4core3fmt5Write10write_char17h40221af7d4326731E+0x79>
ffffffff800002df:	c1 e8 0c             	shr    eax,0xc
ffffffff800002e2:	0c e0                	or     al,0xe0
ffffffff800002e4:	88 44 24 04          	mov    BYTE PTR [rsp+0x4],al
ffffffff800002e8:	89 f0                	mov    eax,esi
ffffffff800002ea:	c1 e8 06             	shr    eax,0x6
ffffffff800002ed:	24 3f                	and    al,0x3f
ffffffff800002ef:	0c 80                	or     al,0x80
ffffffff800002f1:	88 44 24 05          	mov    BYTE PTR [rsp+0x5],al
ffffffff800002f5:	40 80 e6 3f          	and    sil,0x3f
ffffffff800002f9:	40 80 ce 80          	or     sil,0x80
ffffffff800002fd:	40 88 74 24 06       	mov    BYTE PTR [rsp+0x6],sil
ffffffff80000302:	ba 03 00 00 00       	mov    edx,0x3
ffffffff80000307:	eb 37                	jmp    ffffffff80000340 <_ZN4core3fmt5Write10write_char17h40221af7d4326731E+0xb0>
ffffffff80000309:	c1 e8 12             	shr    eax,0x12
ffffffff8000030c:	24 07                	and    al,0x7
ffffffff8000030e:	0c f0                	or     al,0xf0
ffffffff80000310:	88 44 24 04          	mov    BYTE PTR [rsp+0x4],al
ffffffff80000314:	89 f0                	mov    eax,esi
ffffffff80000316:	c1 e8 0c             	shr    eax,0xc
ffffffff80000319:	24 3f                	and    al,0x3f
ffffffff8000031b:	0c 80                	or     al,0x80
ffffffff8000031d:	88 44 24 05          	mov    BYTE PTR [rsp+0x5],al
ffffffff80000321:	89 f0                	mov    eax,esi
ffffffff80000323:	c1 e8 06             	shr    eax,0x6
ffffffff80000326:	24 3f                	and    al,0x3f
ffffffff80000328:	0c 80                	or     al,0x80
ffffffff8000032a:	88 44 24 06          	mov    BYTE PTR [rsp+0x6],al
ffffffff8000032e:	40 80 e6 3f          	and    sil,0x3f
ffffffff80000332:	40 80 ce 80          	or     sil,0x80
ffffffff80000336:	40 88 74 24 07       	mov    BYTE PTR [rsp+0x7],sil
ffffffff8000033b:	ba 04 00 00 00       	mov    edx,0x4
ffffffff80000340:	48 8d 74 24 04       	lea    rsi,[rsp+0x4]
ffffffff80000345:	e8 c6 03 00 00       	call   ffffffff80000710 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E>
ffffffff8000034a:	31 c0                	xor    eax,eax
ffffffff8000034c:	59                   	pop    rcx
ffffffff8000034d:	c3                   	ret    
ffffffff8000034e:	cc                   	int3   
ffffffff8000034f:	cc                   	int3   

ffffffff80000350 <_ZN4core3fmt5Write9write_fmt17h30de9a2f66430335E>:
ffffffff80000350:	48 89 f2             	mov    rdx,rsi
ffffffff80000353:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
ffffffff80000357:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
ffffffff8000035b:	48 83 f9 01          	cmp    rcx,0x1
ffffffff8000035f:	74 13                	je     ffffffff80000374 <_ZN4core3fmt5Write9write_fmt17h30de9a2f66430335E+0x24>
ffffffff80000361:	48 85 c9             	test   rcx,rcx
ffffffff80000364:	75 13                	jne    ffffffff80000379 <_ZN4core3fmt5Write9write_fmt17h30de9a2f66430335E+0x29>
ffffffff80000366:	48 85 c0             	test   rax,rax
ffffffff80000369:	75 0e                	jne    ffffffff80000379 <_ZN4core3fmt5Write9write_fmt17h30de9a2f66430335E+0x29>
ffffffff8000036b:	be 01 00 00 00       	mov    esi,0x1
ffffffff80000370:	31 d2                	xor    edx,edx
ffffffff80000372:	eb 1b                	jmp    ffffffff8000038f <_ZN4core3fmt5Write9write_fmt17h30de9a2f66430335E+0x3f>
ffffffff80000374:	48 85 c0             	test   rax,rax
ffffffff80000377:	74 0c                	je     ffffffff80000385 <_ZN4core3fmt5Write9write_fmt17h30de9a2f66430335E+0x35>
ffffffff80000379:	48 8d 35 18 21 01 00 	lea    rsi,[rip+0x12118]        # ffffffff80012498 <memset+0xecb8>
ffffffff80000380:	e9 2b 2b 00 00       	jmp    ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80000385:	48 8b 02             	mov    rax,QWORD PTR [rdx]
ffffffff80000388:	48 8b 30             	mov    rsi,QWORD PTR [rax]
ffffffff8000038b:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
ffffffff8000038f:	50                   	push   rax
ffffffff80000390:	e8 7b 03 00 00       	call   ffffffff80000710 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E>
ffffffff80000395:	31 c0                	xor    eax,eax
ffffffff80000397:	59                   	pop    rcx
ffffffff80000398:	c3                   	ret    
ffffffff80000399:	cc                   	int3   
ffffffff8000039a:	cc                   	int3   
ffffffff8000039b:	cc                   	int3   
ffffffff8000039c:	cc                   	int3   
ffffffff8000039d:	cc                   	int3   
ffffffff8000039e:	cc                   	int3   
ffffffff8000039f:	cc                   	int3   

ffffffff800003a0 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E>:
ffffffff800003a0:	55                   	push   rbp
ffffffff800003a1:	41 57                	push   r15
ffffffff800003a3:	41 56                	push   r14
ffffffff800003a5:	41 55                	push   r13
ffffffff800003a7:	41 54                	push   r12
ffffffff800003a9:	53                   	push   rbx
ffffffff800003aa:	48 83 ec 68          	sub    rsp,0x68
ffffffff800003ae:	48 89 f3             	mov    rbx,rsi
ffffffff800003b1:	83 3f 00             	cmp    DWORD PTR [rdi],0x0
ffffffff800003b4:	74 6d                	je     ffffffff80000423 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0x83>
ffffffff800003b6:	49 89 fe             	mov    r14,rdi
ffffffff800003b9:	4c 8b 7b 20          	mov    r15,QWORD PTR [rbx+0x20]
ffffffff800003bd:	4c 8b 63 28          	mov    r12,QWORD PTR [rbx+0x28]
ffffffff800003c1:	4d 8b 6c 24 18       	mov    r13,QWORD PTR [r12+0x18]
ffffffff800003c6:	48 8d 35 3b 44 00 00 	lea    rsi,[rip+0x443b]        # ffffffff80004808 <memset+0x1028>
ffffffff800003cd:	ba 04 00 00 00       	mov    edx,0x4
ffffffff800003d2:	4c 89 ff             	mov    rdi,r15
ffffffff800003d5:	41 ff d5             	call   r13
ffffffff800003d8:	b1 01                	mov    cl,0x1
ffffffff800003da:	84 c0                	test   al,al
ffffffff800003dc:	0f 85 31 01 00 00    	jne    ffffffff80000513 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0x173>
ffffffff800003e2:	49 83 c6 04          	add    r14,0x4
ffffffff800003e6:	8b 6b 34             	mov    ebp,DWORD PTR [rbx+0x34]
ffffffff800003e9:	40 f6 c5 04          	test   bpl,0x4
ffffffff800003ed:	75 5c                	jne    ffffffff8000044b <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0xab>
ffffffff800003ef:	48 8d 35 0f 60 00 00 	lea    rsi,[rip+0x600f]        # ffffffff80006405 <memset+0x2c25>
ffffffff800003f6:	ba 01 00 00 00       	mov    edx,0x1
ffffffff800003fb:	4c 89 ff             	mov    rdi,r15
ffffffff800003fe:	41 ff d5             	call   r13
ffffffff80000401:	84 c0                	test   al,al
ffffffff80000403:	0f 85 ce 00 00 00    	jne    ffffffff800004d7 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0x137>
ffffffff80000409:	4c 89 f7             	mov    rdi,r14
ffffffff8000040c:	48 89 de             	mov    rsi,rbx
ffffffff8000040f:	e8 ec fb ff ff       	call   ffffffff80000000 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E>
ffffffff80000414:	84 c0                	test   al,al
ffffffff80000416:	b1 01                	mov    cl,0x1
ffffffff80000418:	0f 85 f5 00 00 00    	jne    ffffffff80000513 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0x173>
ffffffff8000041e:	e9 d7 00 00 00       	jmp    ffffffff800004fa <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0x15a>
ffffffff80000423:	48 8b 7b 20          	mov    rdi,QWORD PTR [rbx+0x20]
ffffffff80000427:	48 8b 43 28          	mov    rax,QWORD PTR [rbx+0x28]
ffffffff8000042b:	48 8b 40 18          	mov    rax,QWORD PTR [rax+0x18]
ffffffff8000042f:	48 8d 35 da 43 00 00 	lea    rsi,[rip+0x43da]        # ffffffff80004810 <memset+0x1030>
ffffffff80000436:	ba 04 00 00 00       	mov    edx,0x4
ffffffff8000043b:	48 83 c4 68          	add    rsp,0x68
ffffffff8000043f:	5b                   	pop    rbx
ffffffff80000440:	41 5c                	pop    r12
ffffffff80000442:	41 5d                	pop    r13
ffffffff80000444:	41 5e                	pop    r14
ffffffff80000446:	41 5f                	pop    r15
ffffffff80000448:	5d                   	pop    rbp
ffffffff80000449:	ff e0                	jmp    rax
ffffffff8000044b:	48 8d 35 b4 5f 00 00 	lea    rsi,[rip+0x5fb4]        # ffffffff80006406 <memset+0x2c26>
ffffffff80000452:	ba 02 00 00 00       	mov    edx,0x2
ffffffff80000457:	4c 89 ff             	mov    rdi,r15
ffffffff8000045a:	41 ff d5             	call   r13
ffffffff8000045d:	84 c0                	test   al,al
ffffffff8000045f:	75 76                	jne    ffffffff800004d7 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0x137>
ffffffff80000461:	c6 44 24 0f 01       	mov    BYTE PTR [rsp+0xf],0x1
ffffffff80000466:	4c 89 7c 24 50       	mov    QWORD PTR [rsp+0x50],r15
ffffffff8000046b:	4c 89 64 24 58       	mov    QWORD PTR [rsp+0x58],r12
ffffffff80000470:	48 8d 44 24 0f       	lea    rax,[rsp+0xf]
ffffffff80000475:	48 89 44 24 60       	mov    QWORD PTR [rsp+0x60],rax
ffffffff8000047a:	8b 43 30             	mov    eax,DWORD PTR [rbx+0x30]
ffffffff8000047d:	0f b6 4b 38          	movzx  ecx,BYTE PTR [rbx+0x38]
ffffffff80000481:	48 8b 13             	mov    rdx,QWORD PTR [rbx]
ffffffff80000484:	48 8b 73 08          	mov    rsi,QWORD PTR [rbx+0x8]
ffffffff80000488:	48 8b 7b 10          	mov    rdi,QWORD PTR [rbx+0x10]
ffffffff8000048c:	4c 8b 43 18          	mov    r8,QWORD PTR [rbx+0x18]
ffffffff80000490:	89 6c 24 44          	mov    DWORD PTR [rsp+0x44],ebp
ffffffff80000494:	89 44 24 40          	mov    DWORD PTR [rsp+0x40],eax
ffffffff80000498:	88 4c 24 48          	mov    BYTE PTR [rsp+0x48],cl
ffffffff8000049c:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
ffffffff800004a1:	48 89 74 24 18       	mov    QWORD PTR [rsp+0x18],rsi
ffffffff800004a6:	48 89 7c 24 20       	mov    QWORD PTR [rsp+0x20],rdi
ffffffff800004ab:	4c 89 44 24 28       	mov    QWORD PTR [rsp+0x28],r8
ffffffff800004b0:	48 8d 44 24 50       	lea    rax,[rsp+0x50]
ffffffff800004b5:	48 89 44 24 30       	mov    QWORD PTR [rsp+0x30],rax
ffffffff800004ba:	48 8d 05 1f 5d 01 00 	lea    rax,[rip+0x15d1f]        # ffffffff800161e0 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x100>
ffffffff800004c1:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
ffffffff800004c6:	48 8d 74 24 10       	lea    rsi,[rsp+0x10]
ffffffff800004cb:	4c 89 f7             	mov    rdi,r14
ffffffff800004ce:	e8 2d fb ff ff       	call   ffffffff80000000 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd28404d2497e2e42E>
ffffffff800004d3:	84 c0                	test   al,al
ffffffff800004d5:	74 04                	je     ffffffff800004db <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0x13b>
ffffffff800004d7:	b1 01                	mov    cl,0x1
ffffffff800004d9:	eb 38                	jmp    ffffffff80000513 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0x173>
ffffffff800004db:	48 8b 7c 24 30       	mov    rdi,QWORD PTR [rsp+0x30]
ffffffff800004e0:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
ffffffff800004e5:	48 8d 35 17 5f 00 00 	lea    rsi,[rip+0x5f17]        # ffffffff80006403 <memset+0x2c23>
ffffffff800004ec:	ba 02 00 00 00       	mov    edx,0x2
ffffffff800004f1:	ff 50 18             	call   QWORD PTR [rax+0x18]
ffffffff800004f4:	84 c0                	test   al,al
ffffffff800004f6:	b1 01                	mov    cl,0x1
ffffffff800004f8:	75 19                	jne    ffffffff80000513 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E+0x173>
ffffffff800004fa:	48 8b 7b 20          	mov    rdi,QWORD PTR [rbx+0x20]
ffffffff800004fe:	48 8b 43 28          	mov    rax,QWORD PTR [rbx+0x28]
ffffffff80000502:	48 8d 35 d5 5e 00 00 	lea    rsi,[rip+0x5ed5]        # ffffffff800063de <memset+0x2bfe>
ffffffff80000509:	ba 01 00 00 00       	mov    edx,0x1
ffffffff8000050e:	ff 50 18             	call   QWORD PTR [rax+0x18]
ffffffff80000511:	89 c1                	mov    ecx,eax
ffffffff80000513:	89 c8                	mov    eax,ecx
ffffffff80000515:	48 83 c4 68          	add    rsp,0x68
ffffffff80000519:	5b                   	pop    rbx
ffffffff8000051a:	41 5c                	pop    r12
ffffffff8000051c:	41 5d                	pop    r13
ffffffff8000051e:	41 5e                	pop    r14
ffffffff80000520:	41 5f                	pop    r15
ffffffff80000522:	5d                   	pop    rbp
ffffffff80000523:	c3                   	ret    
ffffffff80000524:	cc                   	int3   
ffffffff80000525:	cc                   	int3   
ffffffff80000526:	cc                   	int3   
ffffffff80000527:	cc                   	int3   
ffffffff80000528:	cc                   	int3   
ffffffff80000529:	cc                   	int3   
ffffffff8000052a:	cc                   	int3   
ffffffff8000052b:	cc                   	int3   
ffffffff8000052c:	cc                   	int3   
ffffffff8000052d:	cc                   	int3   
ffffffff8000052e:	cc                   	int3   
ffffffff8000052f:	cc                   	int3   

ffffffff80000530 <_ZN76_$LT$core..panic..panic_info..PanicMessage$u20$as$u20$core..fmt..Display$GT$3fmt17h030ce0cb2da8e6e2E>:
ffffffff80000530:	48 89 fa             	mov    rdx,rdi
ffffffff80000533:	48 8b 7e 20          	mov    rdi,QWORD PTR [rsi+0x20]
ffffffff80000537:	48 8b 76 28          	mov    rsi,QWORD PTR [rsi+0x28]
ffffffff8000053b:	48 8b 4a 08          	mov    rcx,QWORD PTR [rdx+0x8]
ffffffff8000053f:	48 8b 42 18          	mov    rax,QWORD PTR [rdx+0x18]
ffffffff80000543:	48 83 f9 01          	cmp    rcx,0x1
ffffffff80000547:	74 22                	je     ffffffff8000056b <_ZN76_$LT$core..panic..panic_info..PanicMessage$u20$as$u20$core..fmt..Display$GT$3fmt17h030ce0cb2da8e6e2E+0x3b>
ffffffff80000549:	48 85 c9             	test   rcx,rcx
ffffffff8000054c:	0f 85 5e 29 00 00    	jne    ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80000552:	48 85 c0             	test   rax,rax
ffffffff80000555:	0f 85 55 29 00 00    	jne    ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff8000055b:	b8 01 00 00 00       	mov    eax,0x1
ffffffff80000560:	31 d2                	xor    edx,edx
ffffffff80000562:	48 8b 4e 18          	mov    rcx,QWORD PTR [rsi+0x18]
ffffffff80000566:	48 89 c6             	mov    rsi,rax
ffffffff80000569:	ff e1                	jmp    rcx
ffffffff8000056b:	48 85 c0             	test   rax,rax
ffffffff8000056e:	0f 85 3c 29 00 00    	jne    ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80000574:	48 8b 0a             	mov    rcx,QWORD PTR [rdx]
ffffffff80000577:	48 8b 01             	mov    rax,QWORD PTR [rcx]
ffffffff8000057a:	48 8b 51 08          	mov    rdx,QWORD PTR [rcx+0x8]
ffffffff8000057e:	48 8b 4e 18          	mov    rcx,QWORD PTR [rsi+0x18]
ffffffff80000582:	48 89 c6             	mov    rsi,rax
ffffffff80000585:	ff e1                	jmp    rcx
ffffffff80000587:	cc                   	int3   
ffffffff80000588:	cc                   	int3   
ffffffff80000589:	cc                   	int3   
ffffffff8000058a:	cc                   	int3   
ffffffff8000058b:	cc                   	int3   
ffffffff8000058c:	cc                   	int3   
ffffffff8000058d:	cc                   	int3   
ffffffff8000058e:	cc                   	int3   
ffffffff8000058f:	cc                   	int3   

ffffffff80000590 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE>:
ffffffff80000590:	55                   	push   rbp
ffffffff80000591:	41 57                	push   r15
ffffffff80000593:	41 56                	push   r14
ffffffff80000595:	41 55                	push   r13
ffffffff80000597:	41 54                	push   r12
ffffffff80000599:	53                   	push   rbx
ffffffff8000059a:	48 83 ec 38          	sub    rsp,0x38
ffffffff8000059e:	48 8b 05 cb 5d 01 00 	mov    rax,QWORD PTR [rip+0x15dcb]        # ffffffff80016370 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x38>
ffffffff800005a5:	48 8b 1d ac 5d 01 00 	mov    rbx,QWORD PTR [rip+0x15dac]        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff800005ac:	48 b9 8f e3 38 8e e3 	movabs rcx,0xe38e38e38e38e38f
ffffffff800005b3:	38 8e e3 
ffffffff800005b6:	48 89 da             	mov    rdx,rbx
ffffffff800005b9:	c4 e2 f3 f6 c9       	mulx   rcx,rcx,rcx
ffffffff800005be:	48 c1 e9 04          	shr    rcx,0x4
ffffffff800005c2:	48 ff c9             	dec    rcx
ffffffff800005c5:	48 39 c8             	cmp    rax,rcx
ffffffff800005c8:	0f 85 d7 00 00 00    	jne    ffffffff800006a5 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0x115>
ffffffff800005ce:	49 89 de             	mov    r14,rbx
ffffffff800005d1:	49 83 c6 ee          	add    r14,0xffffffffffffffee
ffffffff800005d5:	74 7e                	je     ffffffff80000655 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0xc5>
ffffffff800005d7:	48 83 fb 13          	cmp    rbx,0x13
ffffffff800005db:	41 bf 12 00 00 00    	mov    r15d,0x12
ffffffff800005e1:	4c 0f 43 fb          	cmovae r15,rbx
ffffffff800005e5:	49 83 c7 ee          	add    r15,0xffffffffffffffee
ffffffff800005e9:	4c 8d 63 ee          	lea    r12,[rbx-0x12]
ffffffff800005ed:	31 f6                	xor    esi,esi
ffffffff800005ef:	4c 8b 2d 32 5d 01 00 	mov    r13,QWORD PTR [rip+0x15d32]        # ffffffff80016328 <_DYNAMIC+0xe0>
ffffffff800005f6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
ffffffff800005fd:	00 00 00 
ffffffff80000600:	48 39 f3             	cmp    rbx,rsi
ffffffff80000603:	0f 84 c0 00 00 00    	je     ffffffff800006c9 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0x139>
ffffffff80000609:	49 39 f7             	cmp    r15,rsi
ffffffff8000060c:	0f 84 b7 00 00 00    	je     ffffffff800006c9 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0x139>
ffffffff80000612:	48 8d 6e 01          	lea    rbp,[rsi+0x1]
ffffffff80000616:	48 8b 15 33 5d 01 00 	mov    rdx,QWORD PTR [rip+0x15d33]        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff8000061d:	48 c1 e2 02          	shl    rdx,0x2
ffffffff80000621:	48 8b 05 20 5d 01 00 	mov    rax,QWORD PTR [rip+0x15d20]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff80000628:	48 8b 0d 31 5d 01 00 	mov    rcx,QWORD PTR [rip+0x15d31]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff8000062f:	48 89 cf             	mov    rdi,rcx
ffffffff80000632:	48 0f af fe          	imul   rdi,rsi
ffffffff80000636:	48 83 c6 12          	add    rsi,0x12
ffffffff8000063a:	48 01 c7             	add    rdi,rax
ffffffff8000063d:	48 0f af f1          	imul   rsi,rcx
ffffffff80000641:	48 01 c6             	add    rsi,rax
ffffffff80000644:	41 ff d5             	call   r13
ffffffff80000647:	48 89 ee             	mov    rsi,rbp
ffffffff8000064a:	49 39 ec             	cmp    r12,rbp
ffffffff8000064d:	75 b1                	jne    ffffffff80000600 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0x70>
ffffffff8000064f:	48 83 fb 12          	cmp    rbx,0x12
ffffffff80000653:	72 5a                	jb     ffffffff800006af <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0x11f>
ffffffff80000655:	48 8b 05 f4 5c 01 00 	mov    rax,QWORD PTR [rip+0x15cf4]        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff8000065c:	4c 8b 3d cd 5c 01 00 	mov    r15,QWORD PTR [rip+0x15ccd]        # ffffffff80016330 <_DYNAMIC+0xe8>
ffffffff80000663:	eb 13                	jmp    ffffffff80000678 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0xe8>
ffffffff80000665:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff8000066c:	00 00 00 00 
ffffffff80000670:	49 ff c6             	inc    r14
ffffffff80000673:	49 39 de             	cmp    r14,rbx
ffffffff80000676:	73 37                	jae    ffffffff800006af <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0x11f>
ffffffff80000678:	48 8d 14 85 00 00 00 	lea    rdx,[rax*4+0x0]
ffffffff8000067f:	00 
ffffffff80000680:	48 85 d2             	test   rdx,rdx
ffffffff80000683:	74 eb                	je     ffffffff80000670 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0xe0>
ffffffff80000685:	48 8b 3d d4 5c 01 00 	mov    rdi,QWORD PTR [rip+0x15cd4]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff8000068c:	49 0f af fe          	imul   rdi,r14
ffffffff80000690:	48 03 3d b1 5c 01 00 	add    rdi,QWORD PTR [rip+0x15cb1]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff80000697:	31 f6                	xor    esi,esi
ffffffff80000699:	41 ff d7             	call   r15
ffffffff8000069c:	48 8b 05 ad 5c 01 00 	mov    rax,QWORD PTR [rip+0x15cad]        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff800006a3:	eb cb                	jmp    ffffffff80000670 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE+0xe0>
ffffffff800006a5:	48 ff c0             	inc    rax
ffffffff800006a8:	48 89 05 c1 5c 01 00 	mov    QWORD PTR [rip+0x15cc1],rax        # ffffffff80016370 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x38>
ffffffff800006af:	48 c7 05 ae 5c 01 00 	mov    QWORD PTR [rip+0x15cae],0x0        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff800006b6:	00 00 00 00 
ffffffff800006ba:	48 83 c4 38          	add    rsp,0x38
ffffffff800006be:	5b                   	pop    rbx
ffffffff800006bf:	41 5c                	pop    r12
ffffffff800006c1:	41 5d                	pop    r13
ffffffff800006c3:	41 5e                	pop    r14
ffffffff800006c5:	41 5f                	pop    r15
ffffffff800006c7:	5d                   	pop    rbp
ffffffff800006c8:	c3                   	ret    
ffffffff800006c9:	48 8d 05 d0 58 01 00 	lea    rax,[rip+0x158d0]        # ffffffff80015fa0 <memset+0x127c0>
ffffffff800006d0:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
ffffffff800006d5:	48 c7 44 24 10 01 00 	mov    QWORD PTR [rsp+0x10],0x1
ffffffff800006dc:	00 00 
ffffffff800006de:	48 c7 44 24 28 00 00 	mov    QWORD PTR [rsp+0x28],0x0
ffffffff800006e5:	00 00 
ffffffff800006e7:	48 c7 44 24 18 08 00 	mov    QWORD PTR [rsp+0x18],0x8
ffffffff800006ee:	00 00 
ffffffff800006f0:	48 c7 44 24 20 00 00 	mov    QWORD PTR [rsp+0x20],0x0
ffffffff800006f7:	00 00 
ffffffff800006f9:	48 8d 35 c8 58 01 00 	lea    rsi,[rip+0x158c8]        # ffffffff80015fc8 <memset+0x127e8>
ffffffff80000700:	48 8d 7c 24 08       	lea    rdi,[rsp+0x8]
ffffffff80000705:	e8 66 1a 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff8000070a:	cc                   	int3   
ffffffff8000070b:	cc                   	int3   
ffffffff8000070c:	cc                   	int3   
ffffffff8000070d:	cc                   	int3   
ffffffff8000070e:	cc                   	int3   
ffffffff8000070f:	cc                   	int3   

ffffffff80000710 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E>:
ffffffff80000710:	55                   	push   rbp
ffffffff80000711:	41 57                	push   r15
ffffffff80000713:	41 56                	push   r14
ffffffff80000715:	41 55                	push   r13
ffffffff80000717:	41 54                	push   r12
ffffffff80000719:	53                   	push   rbx
ffffffff8000071a:	48 81 ec 88 00 00 00 	sub    rsp,0x88
ffffffff80000721:	49 89 d6             	mov    r14,rdx
ffffffff80000724:	49 89 f7             	mov    r15,rsi
ffffffff80000727:	b1 01                	mov    cl,0x1
ffffffff80000729:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
ffffffff80000730:	31 c0                	xor    eax,eax
ffffffff80000732:	f0 0f b0 0d fe 5b 01 	lock cmpxchg BYTE PTR [rip+0x15bfe],cl        # ffffffff80016338 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E>
ffffffff80000739:	00 
ffffffff8000073a:	75 06                	jne    ffffffff80000742 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x32>
ffffffff8000073c:	eb 11                	jmp    ffffffff8000074f <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x3f>
ffffffff8000073e:	66 90                	xchg   ax,ax
ffffffff80000740:	f3 90                	pause  
ffffffff80000742:	0f b6 05 ef 5b 01 00 	movzx  eax,BYTE PTR [rip+0x15bef]        # ffffffff80016338 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E>
ffffffff80000749:	84 c0                	test   al,al
ffffffff8000074b:	75 f3                	jne    ffffffff80000740 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x30>
ffffffff8000074d:	eb e1                	jmp    ffffffff80000730 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x20>
ffffffff8000074f:	48 83 3d e9 5b 01 00 	cmp    QWORD PTR [rip+0x15be9],0x0        # ffffffff80016340 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x8>
ffffffff80000756:	00 
ffffffff80000757:	0f 84 01 06 00 00    	je     ffffffff80000d5e <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x64e>
ffffffff8000075d:	4d 85 f6             	test   r14,r14
ffffffff80000760:	0f 84 f8 05 00 00    	je     ffffffff80000d5e <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x64e>
ffffffff80000766:	4d 01 fe             	add    r14,r15
ffffffff80000769:	4c 89 34 24          	mov    QWORD PTR [rsp],r14
ffffffff8000076d:	eb 0f                	jmp    ffffffff8000077e <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6e>
ffffffff8000076f:	90                   	nop
ffffffff80000770:	e8 1b fe ff ff       	call   ffffffff80000590 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE>
ffffffff80000775:	4d 39 f7             	cmp    r15,r14
ffffffff80000778:	0f 84 e0 05 00 00    	je     ffffffff80000d5e <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x64e>
ffffffff8000077e:	41 0f b6 1f          	movzx  ebx,BYTE PTR [r15]
ffffffff80000782:	84 db                	test   bl,bl
ffffffff80000784:	78 1a                	js     ffffffff800007a0 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x90>
ffffffff80000786:	49 ff c7             	inc    r15
ffffffff80000789:	83 fb 20             	cmp    ebx,0x20
ffffffff8000078c:	0f 85 7e 00 00 00    	jne    ffffffff80000810 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x100>
ffffffff80000792:	e9 9d 05 00 00       	jmp    ffffffff80000d34 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x624>
ffffffff80000797:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
ffffffff8000079e:	00 00 
ffffffff800007a0:	89 d8                	mov    eax,ebx
ffffffff800007a2:	83 e0 1f             	and    eax,0x1f
ffffffff800007a5:	41 0f b6 57 01       	movzx  edx,BYTE PTR [r15+0x1]
ffffffff800007aa:	83 e2 3f             	and    edx,0x3f
ffffffff800007ad:	80 fb df             	cmp    bl,0xdf
ffffffff800007b0:	76 35                	jbe    ffffffff800007e7 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0xd7>
ffffffff800007b2:	41 0f b6 4f 02       	movzx  ecx,BYTE PTR [r15+0x2]
ffffffff800007b7:	c1 e2 06             	shl    edx,0x6
ffffffff800007ba:	83 e1 3f             	and    ecx,0x3f
ffffffff800007bd:	09 d1                	or     ecx,edx
ffffffff800007bf:	80 fb f0             	cmp    bl,0xf0
ffffffff800007c2:	72 38                	jb     ffffffff800007fc <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0xec>
ffffffff800007c4:	41 0f b6 5f 03       	movzx  ebx,BYTE PTR [r15+0x3]
ffffffff800007c9:	49 83 c7 04          	add    r15,0x4
ffffffff800007cd:	83 e0 07             	and    eax,0x7
ffffffff800007d0:	c1 e0 12             	shl    eax,0x12
ffffffff800007d3:	c1 e1 06             	shl    ecx,0x6
ffffffff800007d6:	83 e3 3f             	and    ebx,0x3f
ffffffff800007d9:	09 cb                	or     ebx,ecx
ffffffff800007db:	09 c3                	or     ebx,eax
ffffffff800007dd:	83 fb 20             	cmp    ebx,0x20
ffffffff800007e0:	75 2e                	jne    ffffffff80000810 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x100>
ffffffff800007e2:	e9 4d 05 00 00       	jmp    ffffffff80000d34 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x624>
ffffffff800007e7:	49 83 c7 02          	add    r15,0x2
ffffffff800007eb:	c1 e0 06             	shl    eax,0x6
ffffffff800007ee:	09 d0                	or     eax,edx
ffffffff800007f0:	89 c3                	mov    ebx,eax
ffffffff800007f2:	83 fb 20             	cmp    ebx,0x20
ffffffff800007f5:	75 19                	jne    ffffffff80000810 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x100>
ffffffff800007f7:	e9 38 05 00 00       	jmp    ffffffff80000d34 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x624>
ffffffff800007fc:	49 83 c7 03          	add    r15,0x3
ffffffff80000800:	c1 e0 0c             	shl    eax,0xc
ffffffff80000803:	09 c1                	or     ecx,eax
ffffffff80000805:	89 cb                	mov    ebx,ecx
ffffffff80000807:	83 fb 20             	cmp    ebx,0x20
ffffffff8000080a:	0f 84 24 05 00 00    	je     ffffffff80000d34 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x624>
ffffffff80000810:	83 fb 0a             	cmp    ebx,0xa
ffffffff80000813:	0f 84 57 ff ff ff    	je     ffffffff80000770 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x60>
ffffffff80000819:	83 fb 09             	cmp    ebx,0x9
ffffffff8000081c:	75 72                	jne    ffffffff80000890 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x180>
ffffffff8000081e:	48 8b 05 43 5b 01 00 	mov    rax,QWORD PTR [rip+0x15b43]        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000825:	48 8b 0d 24 5b 01 00 	mov    rcx,QWORD PTR [rip+0x15b24]        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff8000082c:	48 c1 e9 03          	shr    rcx,0x3
ffffffff80000830:	48 39 c8             	cmp    rax,rcx
ffffffff80000833:	0f 85 c3 04 00 00    	jne    ffffffff80000cfc <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x5ec>
ffffffff80000839:	e8 52 fd ff ff       	call   ffffffff80000590 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE>
ffffffff8000083e:	48 8b 05 23 5b 01 00 	mov    rax,QWORD PTR [rip+0x15b23]        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000845:	48 8b 0d 04 5b 01 00 	mov    rcx,QWORD PTR [rip+0x15b04]        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff8000084c:	48 c1 e9 03          	shr    rcx,0x3
ffffffff80000850:	48 39 c8             	cmp    rax,rcx
ffffffff80000853:	0f 84 b6 04 00 00    	je     ffffffff80000d0f <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x5ff>
ffffffff80000859:	48 ff c0             	inc    rax
ffffffff8000085c:	48 89 05 05 5b 01 00 	mov    QWORD PTR [rip+0x15b05],rax        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000863:	48 39 c8             	cmp    rax,rcx
ffffffff80000866:	0f 84 c3 04 00 00    	je     ffffffff80000d2f <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x61f>
ffffffff8000086c:	48 ff c0             	inc    rax
ffffffff8000086f:	48 89 05 f2 5a 01 00 	mov    QWORD PTR [rip+0x15af2],rax        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000876:	48 39 c8             	cmp    rax,rcx
ffffffff80000879:	0f 84 f1 fe ff ff    	je     ffffffff80000770 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x60>
ffffffff8000087f:	e9 cb 04 00 00       	jmp    ffffffff80000d4f <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x63f>
ffffffff80000884:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff8000088b:	00 00 00 00 00 
ffffffff80000890:	48 8b 15 d1 5a 01 00 	mov    rdx,QWORD PTR [rip+0x15ad1]        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000897:	48 8b 0d b2 5a 01 00 	mov    rcx,QWORD PTR [rip+0x15ab2]        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff8000089e:	48 c1 e9 03          	shr    rcx,0x3
ffffffff800008a2:	48 89 d0             	mov    rax,rdx
ffffffff800008a5:	48 39 ca             	cmp    rdx,rcx
ffffffff800008a8:	75 0c                	jne    ffffffff800008b6 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x1a6>
ffffffff800008aa:	e8 e1 fc ff ff       	call   ffffffff80000590 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE>
ffffffff800008af:	48 8b 05 b2 5a 01 00 	mov    rax,QWORD PTR [rip+0x15ab2]        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff800008b6:	4c 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],r15
ffffffff800008bb:	89 da                	mov    edx,ebx
ffffffff800008bd:	48 8d 4a df          	lea    rcx,[rdx-0x21]
ffffffff800008c1:	48 83 f9 5e          	cmp    rcx,0x5e
ffffffff800008c5:	0f 83 30 05 00 00    	jae    ffffffff80000dfb <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6eb>
ffffffff800008cb:	48 89 c7             	mov    rdi,rax
ffffffff800008ce:	48 8d 0c c5 00 00 00 	lea    rcx,[rax*8+0x0]
ffffffff800008d5:	00 
ffffffff800008d6:	48 8b 35 93 5a 01 00 	mov    rsi,QWORD PTR [rip+0x15a93]        # ffffffff80016370 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x38>
ffffffff800008dd:	48 01 f6             	add    rsi,rsi
ffffffff800008e0:	48 8d 04 f6          	lea    rax,[rsi+rsi*8]
ffffffff800008e4:	48 89 44 24 50       	mov    QWORD PTR [rsp+0x50],rax
ffffffff800008e9:	48 8d 05 80 53 01 00 	lea    rax,[rip+0x15380]        # ffffffff80015c70 <memset+0x12490>
ffffffff800008f0:	48 8b b4 d0 f8 fe ff 	mov    rsi,QWORD PTR [rax+rdx*8-0x108]
ffffffff800008f7:	ff 
ffffffff800008f8:	48 c1 e7 05          	shl    rdi,0x5
ffffffff800008fc:	48 89 7c 24 48       	mov    QWORD PTR [rsp+0x48],rdi
ffffffff80000901:	48 89 cf             	mov    rdi,rcx
ffffffff80000904:	48 83 cf 01          	or     rdi,0x1
ffffffff80000908:	48 8d 04 bd 00 00 00 	lea    rax,[rdi*4+0x0]
ffffffff8000090f:	00 
ffffffff80000910:	48 89 44 24 40       	mov    QWORD PTR [rsp+0x40],rax
ffffffff80000915:	49 89 c9             	mov    r9,rcx
ffffffff80000918:	49 83 c9 02          	or     r9,0x2
ffffffff8000091c:	4a 8d 04 8d 00 00 00 	lea    rax,[r9*4+0x0]
ffffffff80000923:	00 
ffffffff80000924:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
ffffffff80000929:	49 89 cb             	mov    r11,rcx
ffffffff8000092c:	49 83 cb 03          	or     r11,0x3
ffffffff80000930:	4a 8d 04 9d 00 00 00 	lea    rax,[r11*4+0x0]
ffffffff80000937:	00 
ffffffff80000938:	48 89 44 24 30       	mov    QWORD PTR [rsp+0x30],rax
ffffffff8000093d:	49 89 cd             	mov    r13,rcx
ffffffff80000940:	49 83 cd 04          	or     r13,0x4
ffffffff80000944:	4a 8d 04 ad 00 00 00 	lea    rax,[r13*4+0x0]
ffffffff8000094b:	00 
ffffffff8000094c:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
ffffffff80000951:	49 89 cf             	mov    r15,rcx
ffffffff80000954:	49 83 cf 05          	or     r15,0x5
ffffffff80000958:	4a 8d 04 bd 00 00 00 	lea    rax,[r15*4+0x0]
ffffffff8000095f:	00 
ffffffff80000960:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff80000965:	49 89 ce             	mov    r14,rcx
ffffffff80000968:	49 83 ce 06          	or     r14,0x6
ffffffff8000096c:	48 89 ca             	mov    rdx,rcx
ffffffff8000096f:	48 83 ca 07          	or     rdx,0x7
ffffffff80000973:	4a 8d 04 b5 00 00 00 	lea    rax,[r14*4+0x0]
ffffffff8000097a:	00 
ffffffff8000097b:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff80000980:	48 8d 04 95 00 00 00 	lea    rax,[rdx*4+0x0]
ffffffff80000987:	00 
ffffffff80000988:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff8000098d:	45 31 e4             	xor    r12d,r12d
ffffffff80000990:	48 39 0d b9 59 01 00 	cmp    QWORD PTR [rip+0x159b9],rcx        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000997:	0f 86 dc 03 00 00    	jbe    ffffffff80000d79 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x669>
ffffffff8000099d:	48 8b 44 24 50       	mov    rax,QWORD PTR [rsp+0x50]
ffffffff800009a2:	4a 8d 2c 20          	lea    rbp,[rax+r12*1]
ffffffff800009a6:	48 39 2d ab 59 01 00 	cmp    QWORD PTR [rip+0x159ab],rbp        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff800009ad:	0f 86 07 04 00 00    	jbe    ffffffff80000dba <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6aa>
ffffffff800009b3:	4a 8b 04 e6          	mov    rax,QWORD PTR [rsi+r12*8]
ffffffff800009b7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
ffffffff800009ba:	48 8b 1d 9f 59 01 00 	mov    rbx,QWORD PTR [rip+0x1599f]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff800009c1:	48 0f af dd          	imul   rbx,rbp
ffffffff800009c5:	44 0f b6 05 ab 59 01 	movzx  r8d,BYTE PTR [rip+0x159ab]        # ffffffff80016378 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x40>
ffffffff800009cc:	00 
ffffffff800009cd:	c4 62 39 f7 c0       	shlx   r8d,eax,r8d
ffffffff800009d2:	44 0f b6 15 9f 59 01 	movzx  r10d,BYTE PTR [rip+0x1599f]        # ffffffff80016379 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x41>
ffffffff800009d9:	00 
ffffffff800009da:	c4 62 29 f7 d0       	shlx   r10d,eax,r10d
ffffffff800009df:	45 09 c2             	or     r10d,r8d
ffffffff800009e2:	44 0f b6 05 90 59 01 	movzx  r8d,BYTE PTR [rip+0x15990]        # ffffffff8001637a <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x42>
ffffffff800009e9:	00 
ffffffff800009ea:	c4 e2 39 f7 c0       	shlx   eax,eax,r8d
ffffffff800009ef:	44 09 d0             	or     eax,r10d
ffffffff800009f2:	4c 8b 05 4f 59 01 00 	mov    r8,QWORD PTR [rip+0x1594f]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff800009f9:	4c 03 44 24 48       	add    r8,QWORD PTR [rsp+0x48]
ffffffff800009fe:	42 89 04 03          	mov    DWORD PTR [rbx+r8*1],eax
ffffffff80000a02:	48 39 3d 47 59 01 00 	cmp    QWORD PTR [rip+0x15947],rdi        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000a09:	0f 86 6a 03 00 00    	jbe    ffffffff80000d79 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x669>
ffffffff80000a0f:	48 39 2d 42 59 01 00 	cmp    QWORD PTR [rip+0x15942],rbp        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff80000a16:	0f 86 9e 03 00 00    	jbe    ffffffff80000dba <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6aa>
ffffffff80000a1c:	4a 8b 04 e6          	mov    rax,QWORD PTR [rsi+r12*8]
ffffffff80000a20:	0f b6 40 01          	movzx  eax,BYTE PTR [rax+0x1]
ffffffff80000a24:	4c 8b 05 35 59 01 00 	mov    r8,QWORD PTR [rip+0x15935]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff80000a2b:	4c 0f af c5          	imul   r8,rbp
ffffffff80000a2f:	44 0f b6 15 41 59 01 	movzx  r10d,BYTE PTR [rip+0x15941]        # ffffffff80016378 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x40>
ffffffff80000a36:	00 
ffffffff80000a37:	c4 62 29 f7 d0       	shlx   r10d,eax,r10d
ffffffff80000a3c:	0f b6 1d 36 59 01 00 	movzx  ebx,BYTE PTR [rip+0x15936]        # ffffffff80016379 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x41>
ffffffff80000a43:	c4 e2 61 f7 d8       	shlx   ebx,eax,ebx
ffffffff80000a48:	44 09 d3             	or     ebx,r10d
ffffffff80000a4b:	44 0f b6 15 27 59 01 	movzx  r10d,BYTE PTR [rip+0x15927]        # ffffffff8001637a <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x42>
ffffffff80000a52:	00 
ffffffff80000a53:	c4 e2 29 f7 c0       	shlx   eax,eax,r10d
ffffffff80000a58:	09 d8                	or     eax,ebx
ffffffff80000a5a:	4c 8b 15 e7 58 01 00 	mov    r10,QWORD PTR [rip+0x158e7]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff80000a61:	4c 03 54 24 40       	add    r10,QWORD PTR [rsp+0x40]
ffffffff80000a66:	43 89 04 10          	mov    DWORD PTR [r8+r10*1],eax
ffffffff80000a6a:	4c 39 0d df 58 01 00 	cmp    QWORD PTR [rip+0x158df],r9        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000a71:	0f 86 02 03 00 00    	jbe    ffffffff80000d79 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x669>
ffffffff80000a77:	48 39 2d da 58 01 00 	cmp    QWORD PTR [rip+0x158da],rbp        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff80000a7e:	0f 86 36 03 00 00    	jbe    ffffffff80000dba <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6aa>
ffffffff80000a84:	4a 8b 04 e6          	mov    rax,QWORD PTR [rsi+r12*8]
ffffffff80000a88:	0f b6 40 02          	movzx  eax,BYTE PTR [rax+0x2]
ffffffff80000a8c:	4c 8b 05 cd 58 01 00 	mov    r8,QWORD PTR [rip+0x158cd]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff80000a93:	4c 0f af c5          	imul   r8,rbp
ffffffff80000a97:	44 0f b6 15 d9 58 01 	movzx  r10d,BYTE PTR [rip+0x158d9]        # ffffffff80016378 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x40>
ffffffff80000a9e:	00 
ffffffff80000a9f:	c4 62 29 f7 d0       	shlx   r10d,eax,r10d
ffffffff80000aa4:	0f b6 1d ce 58 01 00 	movzx  ebx,BYTE PTR [rip+0x158ce]        # ffffffff80016379 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x41>
ffffffff80000aab:	c4 e2 61 f7 d8       	shlx   ebx,eax,ebx
ffffffff80000ab0:	44 09 d3             	or     ebx,r10d
ffffffff80000ab3:	44 0f b6 15 bf 58 01 	movzx  r10d,BYTE PTR [rip+0x158bf]        # ffffffff8001637a <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x42>
ffffffff80000aba:	00 
ffffffff80000abb:	c4 e2 29 f7 c0       	shlx   eax,eax,r10d
ffffffff80000ac0:	09 d8                	or     eax,ebx
ffffffff80000ac2:	4c 8b 15 7f 58 01 00 	mov    r10,QWORD PTR [rip+0x1587f]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff80000ac9:	4c 03 54 24 38       	add    r10,QWORD PTR [rsp+0x38]
ffffffff80000ace:	43 89 04 10          	mov    DWORD PTR [r8+r10*1],eax
ffffffff80000ad2:	4c 39 1d 77 58 01 00 	cmp    QWORD PTR [rip+0x15877],r11        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000ad9:	0f 86 9a 02 00 00    	jbe    ffffffff80000d79 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x669>
ffffffff80000adf:	48 39 2d 72 58 01 00 	cmp    QWORD PTR [rip+0x15872],rbp        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff80000ae6:	0f 86 ce 02 00 00    	jbe    ffffffff80000dba <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6aa>
ffffffff80000aec:	4a 8b 04 e6          	mov    rax,QWORD PTR [rsi+r12*8]
ffffffff80000af0:	0f b6 40 03          	movzx  eax,BYTE PTR [rax+0x3]
ffffffff80000af4:	4c 8b 05 65 58 01 00 	mov    r8,QWORD PTR [rip+0x15865]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff80000afb:	4c 0f af c5          	imul   r8,rbp
ffffffff80000aff:	44 0f b6 15 71 58 01 	movzx  r10d,BYTE PTR [rip+0x15871]        # ffffffff80016378 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x40>
ffffffff80000b06:	00 
ffffffff80000b07:	c4 62 29 f7 d0       	shlx   r10d,eax,r10d
ffffffff80000b0c:	0f b6 1d 66 58 01 00 	movzx  ebx,BYTE PTR [rip+0x15866]        # ffffffff80016379 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x41>
ffffffff80000b13:	c4 e2 61 f7 d8       	shlx   ebx,eax,ebx
ffffffff80000b18:	44 09 d3             	or     ebx,r10d
ffffffff80000b1b:	44 0f b6 15 57 58 01 	movzx  r10d,BYTE PTR [rip+0x15857]        # ffffffff8001637a <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x42>
ffffffff80000b22:	00 
ffffffff80000b23:	c4 e2 29 f7 c0       	shlx   eax,eax,r10d
ffffffff80000b28:	09 d8                	or     eax,ebx
ffffffff80000b2a:	4c 8b 15 17 58 01 00 	mov    r10,QWORD PTR [rip+0x15817]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff80000b31:	4c 03 54 24 30       	add    r10,QWORD PTR [rsp+0x30]
ffffffff80000b36:	43 89 04 10          	mov    DWORD PTR [r8+r10*1],eax
ffffffff80000b3a:	4c 39 2d 0f 58 01 00 	cmp    QWORD PTR [rip+0x1580f],r13        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000b41:	0f 86 32 02 00 00    	jbe    ffffffff80000d79 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x669>
ffffffff80000b47:	48 39 2d 0a 58 01 00 	cmp    QWORD PTR [rip+0x1580a],rbp        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff80000b4e:	0f 86 66 02 00 00    	jbe    ffffffff80000dba <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6aa>
ffffffff80000b54:	4a 8b 04 e6          	mov    rax,QWORD PTR [rsi+r12*8]
ffffffff80000b58:	0f b6 40 04          	movzx  eax,BYTE PTR [rax+0x4]
ffffffff80000b5c:	4c 8b 05 fd 57 01 00 	mov    r8,QWORD PTR [rip+0x157fd]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff80000b63:	4c 0f af c5          	imul   r8,rbp
ffffffff80000b67:	44 0f b6 15 09 58 01 	movzx  r10d,BYTE PTR [rip+0x15809]        # ffffffff80016378 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x40>
ffffffff80000b6e:	00 
ffffffff80000b6f:	c4 62 29 f7 d0       	shlx   r10d,eax,r10d
ffffffff80000b74:	0f b6 1d fe 57 01 00 	movzx  ebx,BYTE PTR [rip+0x157fe]        # ffffffff80016379 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x41>
ffffffff80000b7b:	c4 e2 61 f7 d8       	shlx   ebx,eax,ebx
ffffffff80000b80:	44 09 d3             	or     ebx,r10d
ffffffff80000b83:	44 0f b6 15 ef 57 01 	movzx  r10d,BYTE PTR [rip+0x157ef]        # ffffffff8001637a <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x42>
ffffffff80000b8a:	00 
ffffffff80000b8b:	c4 e2 29 f7 c0       	shlx   eax,eax,r10d
ffffffff80000b90:	09 d8                	or     eax,ebx
ffffffff80000b92:	4c 8b 15 af 57 01 00 	mov    r10,QWORD PTR [rip+0x157af]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff80000b99:	4c 03 54 24 28       	add    r10,QWORD PTR [rsp+0x28]
ffffffff80000b9e:	43 89 04 10          	mov    DWORD PTR [r8+r10*1],eax
ffffffff80000ba2:	4c 39 3d a7 57 01 00 	cmp    QWORD PTR [rip+0x157a7],r15        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000ba9:	0f 86 ca 01 00 00    	jbe    ffffffff80000d79 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x669>
ffffffff80000baf:	48 39 2d a2 57 01 00 	cmp    QWORD PTR [rip+0x157a2],rbp        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff80000bb6:	0f 86 fe 01 00 00    	jbe    ffffffff80000dba <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6aa>
ffffffff80000bbc:	4a 8b 04 e6          	mov    rax,QWORD PTR [rsi+r12*8]
ffffffff80000bc0:	0f b6 40 05          	movzx  eax,BYTE PTR [rax+0x5]
ffffffff80000bc4:	4c 8b 05 95 57 01 00 	mov    r8,QWORD PTR [rip+0x15795]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff80000bcb:	4c 0f af c5          	imul   r8,rbp
ffffffff80000bcf:	44 0f b6 15 a1 57 01 	movzx  r10d,BYTE PTR [rip+0x157a1]        # ffffffff80016378 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x40>
ffffffff80000bd6:	00 
ffffffff80000bd7:	c4 62 29 f7 d0       	shlx   r10d,eax,r10d
ffffffff80000bdc:	0f b6 1d 96 57 01 00 	movzx  ebx,BYTE PTR [rip+0x15796]        # ffffffff80016379 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x41>
ffffffff80000be3:	c4 e2 61 f7 d8       	shlx   ebx,eax,ebx
ffffffff80000be8:	44 09 d3             	or     ebx,r10d
ffffffff80000beb:	44 0f b6 15 87 57 01 	movzx  r10d,BYTE PTR [rip+0x15787]        # ffffffff8001637a <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x42>
ffffffff80000bf2:	00 
ffffffff80000bf3:	c4 e2 29 f7 c0       	shlx   eax,eax,r10d
ffffffff80000bf8:	09 d8                	or     eax,ebx
ffffffff80000bfa:	4c 8b 15 47 57 01 00 	mov    r10,QWORD PTR [rip+0x15747]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff80000c01:	4c 03 54 24 20       	add    r10,QWORD PTR [rsp+0x20]
ffffffff80000c06:	43 89 04 10          	mov    DWORD PTR [r8+r10*1],eax
ffffffff80000c0a:	4c 39 35 3f 57 01 00 	cmp    QWORD PTR [rip+0x1573f],r14        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000c11:	0f 86 62 01 00 00    	jbe    ffffffff80000d79 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x669>
ffffffff80000c17:	48 39 2d 3a 57 01 00 	cmp    QWORD PTR [rip+0x1573a],rbp        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff80000c1e:	0f 86 96 01 00 00    	jbe    ffffffff80000dba <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6aa>
ffffffff80000c24:	4a 8b 04 e6          	mov    rax,QWORD PTR [rsi+r12*8]
ffffffff80000c28:	0f b6 40 06          	movzx  eax,BYTE PTR [rax+0x6]
ffffffff80000c2c:	4c 8b 05 2d 57 01 00 	mov    r8,QWORD PTR [rip+0x1572d]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff80000c33:	4c 0f af c5          	imul   r8,rbp
ffffffff80000c37:	44 0f b6 15 39 57 01 	movzx  r10d,BYTE PTR [rip+0x15739]        # ffffffff80016378 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x40>
ffffffff80000c3e:	00 
ffffffff80000c3f:	c4 62 29 f7 d0       	shlx   r10d,eax,r10d
ffffffff80000c44:	0f b6 1d 2e 57 01 00 	movzx  ebx,BYTE PTR [rip+0x1572e]        # ffffffff80016379 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x41>
ffffffff80000c4b:	c4 e2 61 f7 d8       	shlx   ebx,eax,ebx
ffffffff80000c50:	44 09 d3             	or     ebx,r10d
ffffffff80000c53:	44 0f b6 15 1f 57 01 	movzx  r10d,BYTE PTR [rip+0x1571f]        # ffffffff8001637a <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x42>
ffffffff80000c5a:	00 
ffffffff80000c5b:	c4 e2 29 f7 c0       	shlx   eax,eax,r10d
ffffffff80000c60:	09 d8                	or     eax,ebx
ffffffff80000c62:	4c 8b 15 df 56 01 00 	mov    r10,QWORD PTR [rip+0x156df]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff80000c69:	4c 03 54 24 18       	add    r10,QWORD PTR [rsp+0x18]
ffffffff80000c6e:	43 89 04 10          	mov    DWORD PTR [r8+r10*1],eax
ffffffff80000c72:	48 39 15 d7 56 01 00 	cmp    QWORD PTR [rip+0x156d7],rdx        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000c79:	0f 86 fa 00 00 00    	jbe    ffffffff80000d79 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x669>
ffffffff80000c7f:	48 39 2d d2 56 01 00 	cmp    QWORD PTR [rip+0x156d2],rbp        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff80000c86:	0f 86 2e 01 00 00    	jbe    ffffffff80000dba <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x6aa>
ffffffff80000c8c:	4a 8b 04 e6          	mov    rax,QWORD PTR [rsi+r12*8]
ffffffff80000c90:	49 ff c4             	inc    r12
ffffffff80000c93:	0f b6 40 07          	movzx  eax,BYTE PTR [rax+0x7]
ffffffff80000c97:	48 0f af 2d c1 56 01 	imul   rbp,QWORD PTR [rip+0x156c1]        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff80000c9e:	00 
ffffffff80000c9f:	44 0f b6 05 d1 56 01 	movzx  r8d,BYTE PTR [rip+0x156d1]        # ffffffff80016378 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x40>
ffffffff80000ca6:	00 
ffffffff80000ca7:	c4 62 39 f7 c0       	shlx   r8d,eax,r8d
ffffffff80000cac:	44 0f b6 15 c5 56 01 	movzx  r10d,BYTE PTR [rip+0x156c5]        # ffffffff80016379 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x41>
ffffffff80000cb3:	00 
ffffffff80000cb4:	c4 62 29 f7 d0       	shlx   r10d,eax,r10d
ffffffff80000cb9:	45 09 c2             	or     r10d,r8d
ffffffff80000cbc:	44 0f b6 05 b6 56 01 	movzx  r8d,BYTE PTR [rip+0x156b6]        # ffffffff8001637a <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x42>
ffffffff80000cc3:	00 
ffffffff80000cc4:	c4 e2 39 f7 c0       	shlx   eax,eax,r8d
ffffffff80000cc9:	44 09 d0             	or     eax,r10d
ffffffff80000ccc:	4c 8b 05 75 56 01 00 	mov    r8,QWORD PTR [rip+0x15675]        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff80000cd3:	4c 03 44 24 10       	add    r8,QWORD PTR [rsp+0x10]
ffffffff80000cd8:	42 89 44 05 00       	mov    DWORD PTR [rbp+r8*1+0x0],eax
ffffffff80000cdd:	49 83 fc 12          	cmp    r12,0x12
ffffffff80000ce1:	0f 85 a9 fc ff ff    	jne    ffffffff80000990 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x280>
ffffffff80000ce7:	48 ff 05 7a 56 01 00 	inc    QWORD PTR [rip+0x1567a]        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000cee:	4c 8b 34 24          	mov    r14,QWORD PTR [rsp]
ffffffff80000cf2:	4c 8b 7c 24 08       	mov    r15,QWORD PTR [rsp+0x8]
ffffffff80000cf7:	e9 79 fa ff ff       	jmp    ffffffff80000775 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x65>
ffffffff80000cfc:	48 ff c0             	inc    rax
ffffffff80000cff:	48 89 05 62 56 01 00 	mov    QWORD PTR [rip+0x15662],rax        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000d06:	48 39 c8             	cmp    rax,rcx
ffffffff80000d09:	0f 85 4a fb ff ff    	jne    ffffffff80000859 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x149>
ffffffff80000d0f:	e8 7c f8 ff ff       	call   ffffffff80000590 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE>
ffffffff80000d14:	48 8b 05 4d 56 01 00 	mov    rax,QWORD PTR [rip+0x1564d]        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000d1b:	48 8b 0d 2e 56 01 00 	mov    rcx,QWORD PTR [rip+0x1562e]        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000d22:	48 c1 e9 03          	shr    rcx,0x3
ffffffff80000d26:	48 39 c8             	cmp    rax,rcx
ffffffff80000d29:	0f 85 3d fb ff ff    	jne    ffffffff8000086c <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x15c>
ffffffff80000d2f:	e8 5c f8 ff ff       	call   ffffffff80000590 <_ZN6kernel11debug_print12DebugPrinter8new_line17h3664b87b52f750bdE>
ffffffff80000d34:	48 8b 05 2d 56 01 00 	mov    rax,QWORD PTR [rip+0x1562d]        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000d3b:	48 8b 0d 0e 56 01 00 	mov    rcx,QWORD PTR [rip+0x1560e]        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff80000d42:	48 c1 e9 03          	shr    rcx,0x3
ffffffff80000d46:	48 39 c8             	cmp    rax,rcx
ffffffff80000d49:	0f 84 21 fa ff ff    	je     ffffffff80000770 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x60>
ffffffff80000d4f:	48 ff c0             	inc    rax
ffffffff80000d52:	48 89 05 0f 56 01 00 	mov    QWORD PTR [rip+0x1560f],rax        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff80000d59:	e9 17 fa ff ff       	jmp    ffffffff80000775 <_ZN64_$LT$kernel..debug_print..Helper$u20$as$u20$core..fmt..Write$GT$9write_str17h2a7d3ab571c8e745E+0x65>
ffffffff80000d5e:	c6 05 d3 55 01 00 00 	mov    BYTE PTR [rip+0x155d3],0x0        # ffffffff80016338 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E>
ffffffff80000d65:	31 c0                	xor    eax,eax
ffffffff80000d67:	48 81 c4 88 00 00 00 	add    rsp,0x88
ffffffff80000d6e:	5b                   	pop    rbx
ffffffff80000d6f:	41 5c                	pop    r12
ffffffff80000d71:	41 5d                	pop    r13
ffffffff80000d73:	41 5e                	pop    r14
ffffffff80000d75:	41 5f                	pop    r15
ffffffff80000d77:	5d                   	pop    rbp
ffffffff80000d78:	c3                   	ret    
ffffffff80000d79:	48 8d 05 f8 51 01 00 	lea    rax,[rip+0x151f8]        # ffffffff80015f78 <memset+0x12798>
ffffffff80000d80:	48 89 44 24 58       	mov    QWORD PTR [rsp+0x58],rax
ffffffff80000d85:	48 c7 44 24 60 01 00 	mov    QWORD PTR [rsp+0x60],0x1
ffffffff80000d8c:	00 00 
ffffffff80000d8e:	48 c7 44 24 78 00 00 	mov    QWORD PTR [rsp+0x78],0x0
ffffffff80000d95:	00 00 
ffffffff80000d97:	48 c7 44 24 68 08 00 	mov    QWORD PTR [rsp+0x68],0x8
ffffffff80000d9e:	00 00 
ffffffff80000da0:	48 c7 44 24 70 00 00 	mov    QWORD PTR [rsp+0x70],0x0
ffffffff80000da7:	00 00 
ffffffff80000da9:	48 8d 35 d8 51 01 00 	lea    rsi,[rip+0x151d8]        # ffffffff80015f88 <memset+0x127a8>
ffffffff80000db0:	48 8d 7c 24 58       	lea    rdi,[rsp+0x58]
ffffffff80000db5:	e8 b6 13 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80000dba:	48 8d 05 df 51 01 00 	lea    rax,[rip+0x151df]        # ffffffff80015fa0 <memset+0x127c0>
ffffffff80000dc1:	48 89 44 24 58       	mov    QWORD PTR [rsp+0x58],rax
ffffffff80000dc6:	48 c7 44 24 60 01 00 	mov    QWORD PTR [rsp+0x60],0x1
ffffffff80000dcd:	00 00 
ffffffff80000dcf:	48 c7 44 24 78 00 00 	mov    QWORD PTR [rsp+0x78],0x0
ffffffff80000dd6:	00 00 
ffffffff80000dd8:	48 c7 44 24 68 08 00 	mov    QWORD PTR [rsp+0x68],0x8
ffffffff80000ddf:	00 00 
ffffffff80000de1:	48 c7 44 24 70 00 00 	mov    QWORD PTR [rsp+0x70],0x0
ffffffff80000de8:	00 00 
ffffffff80000dea:	48 8d 35 bf 51 01 00 	lea    rsi,[rip+0x151bf]        # ffffffff80015fb0 <memset+0x127d0>
ffffffff80000df1:	48 8d 7c 24 58       	lea    rdi,[rsp+0x58]
ffffffff80000df6:	e8 75 13 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80000dfb:	48 8d 3d d5 3a 00 00 	lea    rdi,[rip+0x3ad5]        # ffffffff800048d7 <memset+0x10f7>
ffffffff80000e02:	48 8d 15 57 51 01 00 	lea    rdx,[rip+0x15157]        # ffffffff80015f60 <memset+0x12780>
ffffffff80000e09:	be 20 00 00 00       	mov    esi,0x20
ffffffff80000e0e:	e8 cd 28 00 00       	call   ffffffff800036e0 <_ZN4core6option13expect_failed17hd9879ea489f48b8fE>
ffffffff80000e13:	cc                   	int3   
ffffffff80000e14:	cc                   	int3   
ffffffff80000e15:	cc                   	int3   
ffffffff80000e16:	cc                   	int3   
ffffffff80000e17:	cc                   	int3   
ffffffff80000e18:	cc                   	int3   
ffffffff80000e19:	cc                   	int3   
ffffffff80000e1a:	cc                   	int3   
ffffffff80000e1b:	cc                   	int3   
ffffffff80000e1c:	cc                   	int3   
ffffffff80000e1d:	cc                   	int3   
ffffffff80000e1e:	cc                   	int3   
ffffffff80000e1f:	cc                   	int3   

ffffffff80000e20 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E>:
ffffffff80000e20:	55                   	push   rbp
ffffffff80000e21:	41 57                	push   r15
ffffffff80000e23:	41 56                	push   r14
ffffffff80000e25:	41 55                	push   r13
ffffffff80000e27:	41 54                	push   r12
ffffffff80000e29:	53                   	push   rbx
ffffffff80000e2a:	48 83 ec 68          	sub    rsp,0x68
ffffffff80000e2e:	48 8b 07             	mov    rax,QWORD PTR [rdi]
ffffffff80000e31:	48 85 c0             	test   rax,rax
ffffffff80000e34:	0f 84 5f 01 00 00    	je     ffffffff80000f99 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x179>
ffffffff80000e3a:	83 f8 01             	cmp    eax,0x1
ffffffff80000e3d:	0f 85 79 03 00 00    	jne    ffffffff800011bc <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x39c>
ffffffff80000e43:	31 c0                	xor    eax,eax
ffffffff80000e45:	31 d2                	xor    edx,edx
ffffffff80000e47:	31 c9                	xor    ecx,ecx
ffffffff80000e49:	31 db                	xor    ebx,ebx
ffffffff80000e4b:	f0 48 0f c7 4f 20    	lock cmpxchg16b OWORD PTR [rdi+0x20]
ffffffff80000e51:	45 31 c0             	xor    r8d,r8d
ffffffff80000e54:	48 89 d1             	mov    rcx,rdx
ffffffff80000e57:	48 f7 d1             	not    rcx
ffffffff80000e5a:	48 89 c6             	mov    rsi,rax
ffffffff80000e5d:	48 f7 d6             	not    rsi
ffffffff80000e60:	f3 4c 0f bc d6       	tzcnt  r10,rsi
ffffffff80000e65:	f3 4c 0f bc c9       	tzcnt  r9,rcx
ffffffff80000e6a:	49 83 c1 40          	add    r9,0x40
ffffffff80000e6e:	48 85 f6             	test   rsi,rsi
ffffffff80000e71:	4d 0f 45 ca          	cmovne r9,r10
ffffffff80000e75:	48 21 d0             	and    rax,rdx
ffffffff80000e78:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
ffffffff80000e7c:	0f 84 24 05 00 00    	je     ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff80000e82:	4c 8b 77 08          	mov    r14,QWORD PTR [rdi+0x8]
ffffffff80000e86:	45 89 cf             	mov    r15d,r9d
ffffffff80000e89:	41 c1 e7 04          	shl    r15d,0x4
ffffffff80000e8d:	31 c0                	xor    eax,eax
ffffffff80000e8f:	31 d2                	xor    edx,edx
ffffffff80000e91:	31 c9                	xor    ecx,ecx
ffffffff80000e93:	31 db                	xor    ebx,ebx
ffffffff80000e95:	f0 4b 0f c7 0c 3e    	lock cmpxchg16b OWORD PTR [r14+r15*1]
ffffffff80000e9b:	49 89 c3             	mov    r11,rax
ffffffff80000e9e:	49 89 d2             	mov    r10,rdx
ffffffff80000ea1:	48 89 d0             	mov    rax,rdx
ffffffff80000ea4:	48 f7 d0             	not    rax
ffffffff80000ea7:	4c 89 da             	mov    rdx,r11
ffffffff80000eaa:	48 f7 d2             	not    rdx
ffffffff80000ead:	31 f6                	xor    esi,esi
ffffffff80000eaf:	f3 48 0f bc f2       	tzcnt  rsi,rdx
ffffffff80000eb4:	31 c9                	xor    ecx,ecx
ffffffff80000eb6:	f3 48 0f bc c8       	tzcnt  rcx,rax
ffffffff80000ebb:	48 83 c1 40          	add    rcx,0x40
ffffffff80000ebf:	48 85 d2             	test   rdx,rdx
ffffffff80000ec2:	48 0f 45 ce          	cmovne rcx,rsi
ffffffff80000ec6:	48 8b 57 10          	mov    rdx,QWORD PTR [rdi+0x10]
ffffffff80000eca:	48 8b 1c ca          	mov    rbx,QWORD PTR [rdx+rcx*8]
ffffffff80000ece:	48 89 d8             	mov    rax,rbx
ffffffff80000ed1:	48 f7 d0             	not    rax
ffffffff80000ed4:	31 f6                	xor    esi,esi
ffffffff80000ed6:	f3 48 0f bc f0       	tzcnt  rsi,rax
ffffffff80000edb:	b8 01 00 00 00       	mov    eax,0x1
ffffffff80000ee0:	c4 62 c9 f7 c0       	shlx   r8,rax,rsi
ffffffff80000ee5:	f0 4c 09 04 ca       	lock or QWORD PTR [rdx+rcx*8],r8
ffffffff80000eea:	48 0f ab f3          	bts    rbx,rsi
ffffffff80000eee:	41 b8 01 00 00 00    	mov    r8d,0x1
ffffffff80000ef4:	48 83 fb ff          	cmp    rbx,0xffffffffffffffff
ffffffff80000ef8:	0f 85 a8 04 00 00    	jne    ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff80000efe:	4d 01 fe             	add    r14,r15
ffffffff80000f01:	31 d2                	xor    edx,edx
ffffffff80000f03:	45 31 ff             	xor    r15d,r15d
ffffffff80000f06:	49 0f a5 c7          	shld   r15,rax,cl
ffffffff80000f0a:	c4 62 f1 f7 e0       	shlx   r12,rax,rcx
ffffffff80000f0f:	f6 c1 40             	test   cl,0x40
ffffffff80000f12:	4d 0f 45 fc          	cmovne r15,r12
ffffffff80000f16:	4c 0f 45 e2          	cmovne r12,rdx
ffffffff80000f1a:	49 8b 06             	mov    rax,QWORD PTR [r14]
ffffffff80000f1d:	49 8b 56 08          	mov    rdx,QWORD PTR [r14+0x8]
ffffffff80000f21:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80000f28:	0f 1f 84 00 00 00 00 
ffffffff80000f2f:	00 
ffffffff80000f30:	48 89 c3             	mov    rbx,rax
ffffffff80000f33:	4c 09 e3             	or     rbx,r12
ffffffff80000f36:	48 89 d1             	mov    rcx,rdx
ffffffff80000f39:	4c 09 f9             	or     rcx,r15
ffffffff80000f3c:	f0 49 0f c7 0e       	lock cmpxchg16b OWORD PTR [r14]
ffffffff80000f41:	75 ed                	jne    ffffffff80000f30 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x110>
ffffffff80000f43:	4d 09 dc             	or     r12,r11
ffffffff80000f46:	4d 09 d7             	or     r15,r10
ffffffff80000f49:	4d 21 e7             	and    r15,r12
ffffffff80000f4c:	49 83 ff ff          	cmp    r15,0xffffffffffffffff
ffffffff80000f50:	0f 85 50 04 00 00    	jne    ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff80000f56:	31 c0                	xor    eax,eax
ffffffff80000f58:	ba 01 00 00 00       	mov    edx,0x1
ffffffff80000f5d:	45 31 d2             	xor    r10d,r10d
ffffffff80000f60:	44 89 c9             	mov    ecx,r9d
ffffffff80000f63:	49 0f a5 d2          	shld   r10,rdx,cl
ffffffff80000f67:	c4 62 b1 f7 da       	shlx   r11,rdx,r9
ffffffff80000f6c:	41 f6 c1 40          	test   r9b,0x40
ffffffff80000f70:	4d 0f 45 d3          	cmovne r10,r11
ffffffff80000f74:	4c 0f 45 d8          	cmovne r11,rax
ffffffff80000f78:	48 8b 47 20          	mov    rax,QWORD PTR [rdi+0x20]
ffffffff80000f7c:	48 8b 57 28          	mov    rdx,QWORD PTR [rdi+0x28]
ffffffff80000f80:	48 89 c3             	mov    rbx,rax
ffffffff80000f83:	4c 09 db             	or     rbx,r11
ffffffff80000f86:	48 89 d1             	mov    rcx,rdx
ffffffff80000f89:	4c 09 d1             	or     rcx,r10
ffffffff80000f8c:	f0 48 0f c7 4f 20    	lock cmpxchg16b OWORD PTR [rdi+0x20]
ffffffff80000f92:	75 ec                	jne    ffffffff80000f80 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x160>
ffffffff80000f94:	e9 0d 04 00 00       	jmp    ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff80000f99:	31 c0                	xor    eax,eax
ffffffff80000f9b:	31 d2                	xor    edx,edx
ffffffff80000f9d:	31 c9                	xor    ecx,ecx
ffffffff80000f9f:	31 db                	xor    ebx,ebx
ffffffff80000fa1:	f0 48 0f c7 4f 10    	lock cmpxchg16b OWORD PTR [rdi+0x10]
ffffffff80000fa7:	45 31 c0             	xor    r8d,r8d
ffffffff80000faa:	48 f7 d2             	not    rdx
ffffffff80000fad:	48 f7 d0             	not    rax
ffffffff80000fb0:	31 c9                	xor    ecx,ecx
ffffffff80000fb2:	f3 48 0f bc c8       	tzcnt  rcx,rax
ffffffff80000fb7:	f3 48 0f bc d2       	tzcnt  rdx,rdx
ffffffff80000fbc:	48 83 c2 40          	add    rdx,0x40
ffffffff80000fc0:	48 85 c0             	test   rax,rax
ffffffff80000fc3:	48 0f 45 d1          	cmovne rdx,rcx
ffffffff80000fc7:	89 54 24 08          	mov    DWORD PTR [rsp+0x8],edx
ffffffff80000fcb:	48 81 fa 80 00 00 00 	cmp    rdx,0x80
ffffffff80000fd2:	0f 84 ce 03 00 00    	je     ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff80000fd8:	48 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],rdi
ffffffff80000fdd:	48 8d 44 24 08       	lea    rax,[rsp+0x8]
ffffffff80000fe2:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff80000fe7:	48 8d 05 e2 20 00 00 	lea    rax,[rip+0x20e2]        # ffffffff800030d0 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E>
ffffffff80000fee:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff80000ff3:	48 8d 05 e6 4f 01 00 	lea    rax,[rip+0x14fe6]        # ffffffff80015fe0 <memset+0x12800>
ffffffff80000ffa:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
ffffffff80000fff:	48 c7 44 24 40 01 00 	mov    QWORD PTR [rsp+0x40],0x1
ffffffff80001006:	00 00 
ffffffff80001008:	48 c7 44 24 58 00 00 	mov    QWORD PTR [rsp+0x58],0x0
ffffffff8000100f:	00 00 
ffffffff80001011:	48 8d 44 24 18       	lea    rax,[rsp+0x18]
ffffffff80001016:	48 89 44 24 48       	mov    QWORD PTR [rsp+0x48],rax
ffffffff8000101b:	48 c7 44 24 50 01 00 	mov    QWORD PTR [rsp+0x50],0x1
ffffffff80001022:	00 00 
ffffffff80001024:	48 8d 35 6d 14 01 00 	lea    rsi,[rip+0x1146d]        # ffffffff80012498 <memset+0xecb8>
ffffffff8000102b:	48 8d 7c 24 07       	lea    rdi,[rsp+0x7]
ffffffff80001030:	48 8d 54 24 38       	lea    rdx,[rsp+0x38]
ffffffff80001035:	e8 76 1e 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff8000103a:	44 8b 64 24 08       	mov    r12d,DWORD PTR [rsp+0x8]
ffffffff8000103f:	49 81 fc 80 00 00 00 	cmp    r12,0x80
ffffffff80001046:	0f 83 7f 03 00 00    	jae    ffffffff800013cb <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x5ab>
ffffffff8000104c:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
ffffffff80001051:	4c 8b 68 08          	mov    r13,QWORD PTR [rax+0x8]
ffffffff80001055:	49 c1 e4 04          	shl    r12,0x4
ffffffff80001059:	31 c0                	xor    eax,eax
ffffffff8000105b:	31 d2                	xor    edx,edx
ffffffff8000105d:	31 c9                	xor    ecx,ecx
ffffffff8000105f:	31 db                	xor    ebx,ebx
ffffffff80001061:	f0 4b 0f c7 4c 25 00 	lock cmpxchg16b OWORD PTR [r13+r12*1+0x0]
ffffffff80001068:	49 89 c6             	mov    r14,rax
ffffffff8000106b:	49 89 d7             	mov    r15,rdx
ffffffff8000106e:	4b 8d 2c 2c          	lea    rbp,[r12+r13*1]
ffffffff80001072:	31 db                	xor    ebx,ebx
ffffffff80001074:	48 89 d0             	mov    rax,rdx
ffffffff80001077:	48 f7 d0             	not    rax
ffffffff8000107a:	4c 89 f1             	mov    rcx,r14
ffffffff8000107d:	48 f7 d1             	not    rcx
ffffffff80001080:	31 d2                	xor    edx,edx
ffffffff80001082:	f3 48 0f bc d1       	tzcnt  rdx,rcx
ffffffff80001087:	f3 48 0f bc c0       	tzcnt  rax,rax
ffffffff8000108c:	83 c0 40             	add    eax,0x40
ffffffff8000108f:	48 85 c9             	test   rcx,rcx
ffffffff80001092:	0f 45 c2             	cmovne eax,edx
ffffffff80001095:	89 44 24 0c          	mov    DWORD PTR [rsp+0xc],eax
ffffffff80001099:	48 8d 44 24 0c       	lea    rax,[rsp+0xc]
ffffffff8000109e:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff800010a3:	48 8d 05 26 20 00 00 	lea    rax,[rip+0x2026]        # ffffffff800030d0 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E>
ffffffff800010aa:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff800010af:	48 8d 05 52 4f 01 00 	lea    rax,[rip+0x14f52]        # ffffffff80016008 <memset+0x12828>
ffffffff800010b6:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
ffffffff800010bb:	48 c7 44 24 40 02 00 	mov    QWORD PTR [rsp+0x40],0x2
ffffffff800010c2:	00 00 
ffffffff800010c4:	48 c7 44 24 58 00 00 	mov    QWORD PTR [rsp+0x58],0x0
ffffffff800010cb:	00 00 
ffffffff800010cd:	48 8d 44 24 18       	lea    rax,[rsp+0x18]
ffffffff800010d2:	48 89 44 24 48       	mov    QWORD PTR [rsp+0x48],rax
ffffffff800010d7:	48 c7 44 24 50 01 00 	mov    QWORD PTR [rsp+0x50],0x1
ffffffff800010de:	00 00 
ffffffff800010e0:	48 8d 35 b1 13 01 00 	lea    rsi,[rip+0x113b1]        # ffffffff80012498 <memset+0xecb8>
ffffffff800010e7:	48 8d 7c 24 07       	lea    rdi,[rsp+0x7]
ffffffff800010ec:	48 8d 54 24 38       	lea    rdx,[rsp+0x38]
ffffffff800010f1:	e8 ba 1d 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff800010f6:	0f b6 4c 24 0c       	movzx  ecx,BYTE PTR [rsp+0xc]
ffffffff800010fb:	b8 01 00 00 00       	mov    eax,0x1
ffffffff80001100:	31 f6                	xor    esi,esi
ffffffff80001102:	48 0f a5 c6          	shld   rsi,rax,cl
ffffffff80001106:	c4 e2 f1 f7 f8       	shlx   rdi,rax,rcx
ffffffff8000110b:	f6 c1 40             	test   cl,0x40
ffffffff8000110e:	48 0f 45 f7          	cmovne rsi,rdi
ffffffff80001112:	48 0f 45 fb          	cmovne rdi,rbx
ffffffff80001116:	4b 8b 44 25 00       	mov    rax,QWORD PTR [r13+r12*1+0x0]
ffffffff8000111b:	4b 8b 54 25 08       	mov    rdx,QWORD PTR [r13+r12*1+0x8]
ffffffff80001120:	48 89 c3             	mov    rbx,rax
ffffffff80001123:	48 09 fb             	or     rbx,rdi
ffffffff80001126:	48 89 d1             	mov    rcx,rdx
ffffffff80001129:	48 09 f1             	or     rcx,rsi
ffffffff8000112c:	f0 48 0f c7 4d 00    	lock cmpxchg16b OWORD PTR [rbp+0x0]
ffffffff80001132:	75 ec                	jne    ffffffff80001120 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x300>
ffffffff80001134:	8b 4c 24 0c          	mov    ecx,DWORD PTR [rsp+0xc]
ffffffff80001138:	b8 01 00 00 00       	mov    eax,0x1
ffffffff8000113d:	31 d2                	xor    edx,edx
ffffffff8000113f:	48 0f a5 c2          	shld   rdx,rax,cl
ffffffff80001143:	31 f6                	xor    esi,esi
ffffffff80001145:	c4 e2 f1 f7 f8       	shlx   rdi,rax,rcx
ffffffff8000114a:	f6 c1 40             	test   cl,0x40
ffffffff8000114d:	48 0f 45 d7          	cmovne rdx,rdi
ffffffff80001151:	48 0f 45 fe          	cmovne rdi,rsi
ffffffff80001155:	4c 09 fa             	or     rdx,r15
ffffffff80001158:	4c 09 f7             	or     rdi,r14
ffffffff8000115b:	48 21 d7             	and    rdi,rdx
ffffffff8000115e:	48 83 ff ff          	cmp    rdi,0xffffffffffffffff
ffffffff80001162:	75 44                	jne    ffffffff800011a8 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x388>
ffffffff80001164:	0f b6 4c 24 08       	movzx  ecx,BYTE PTR [rsp+0x8]
ffffffff80001169:	31 d2                	xor    edx,edx
ffffffff8000116b:	31 f6                	xor    esi,esi
ffffffff8000116d:	48 0f a5 c6          	shld   rsi,rax,cl
ffffffff80001171:	c4 e2 f1 f7 f8       	shlx   rdi,rax,rcx
ffffffff80001176:	f6 c1 40             	test   cl,0x40
ffffffff80001179:	48 0f 45 f7          	cmovne rsi,rdi
ffffffff8000117d:	48 0f 45 fa          	cmovne rdi,rdx
ffffffff80001181:	4c 8b 44 24 10       	mov    r8,QWORD PTR [rsp+0x10]
ffffffff80001186:	49 8b 40 10          	mov    rax,QWORD PTR [r8+0x10]
ffffffff8000118a:	49 8b 50 18          	mov    rdx,QWORD PTR [r8+0x18]
ffffffff8000118e:	66 90                	xchg   ax,ax
ffffffff80001190:	48 89 c3             	mov    rbx,rax
ffffffff80001193:	48 09 fb             	or     rbx,rdi
ffffffff80001196:	48 89 d1             	mov    rcx,rdx
ffffffff80001199:	48 09 f1             	or     rcx,rsi
ffffffff8000119c:	f0 49 0f c7 48 10    	lock cmpxchg16b OWORD PTR [r8+0x10]
ffffffff800011a2:	75 ec                	jne    ffffffff80001190 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x370>
ffffffff800011a4:	8b 4c 24 0c          	mov    ecx,DWORD PTR [rsp+0xc]
ffffffff800011a8:	8b 74 24 08          	mov    esi,DWORD PTR [rsp+0x8]
ffffffff800011ac:	c1 e6 07             	shl    esi,0x7
ffffffff800011af:	01 ce                	add    esi,ecx
ffffffff800011b1:	41 b8 01 00 00 00    	mov    r8d,0x1
ffffffff800011b7:	e9 ea 01 00 00       	jmp    ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff800011bc:	31 c0                	xor    eax,eax
ffffffff800011be:	31 d2                	xor    edx,edx
ffffffff800011c0:	31 c9                	xor    ecx,ecx
ffffffff800011c2:	31 db                	xor    ebx,ebx
ffffffff800011c4:	f0 48 0f c7 4f 20    	lock cmpxchg16b OWORD PTR [rdi+0x20]
ffffffff800011ca:	45 31 c0             	xor    r8d,r8d
ffffffff800011cd:	48 89 d1             	mov    rcx,rdx
ffffffff800011d0:	48 f7 d1             	not    rcx
ffffffff800011d3:	48 89 c6             	mov    rsi,rax
ffffffff800011d6:	48 f7 d6             	not    rsi
ffffffff800011d9:	f3 4c 0f bc d6       	tzcnt  r10,rsi
ffffffff800011de:	f3 4c 0f bc c9       	tzcnt  r9,rcx
ffffffff800011e3:	49 83 c1 40          	add    r9,0x40
ffffffff800011e7:	48 85 f6             	test   rsi,rsi
ffffffff800011ea:	4d 0f 45 ca          	cmovne r9,r10
ffffffff800011ee:	48 21 d0             	and    rax,rdx
ffffffff800011f1:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
ffffffff800011f5:	0f 84 ab 01 00 00    	je     ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff800011fb:	49 83 f9 7f          	cmp    r9,0x7f
ffffffff800011ff:	0f 87 b5 01 00 00    	ja     ffffffff800013ba <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x59a>
ffffffff80001205:	4c 8b 67 08          	mov    r12,QWORD PTR [rdi+0x8]
ffffffff80001209:	45 89 cd             	mov    r13d,r9d
ffffffff8000120c:	41 c1 e5 04          	shl    r13d,0x4
ffffffff80001210:	31 c0                	xor    eax,eax
ffffffff80001212:	31 d2                	xor    edx,edx
ffffffff80001214:	31 c9                	xor    ecx,ecx
ffffffff80001216:	31 db                	xor    ebx,ebx
ffffffff80001218:	f0 4b 0f c7 0c 2c    	lock cmpxchg16b OWORD PTR [r12+r13*1]
ffffffff8000121e:	48 89 c1             	mov    rcx,rax
ffffffff80001221:	48 89 54 24 30       	mov    QWORD PTR [rsp+0x30],rdx
ffffffff80001226:	48 89 d0             	mov    rax,rdx
ffffffff80001229:	48 f7 d0             	not    rax
ffffffff8000122c:	48 89 4c 24 28       	mov    QWORD PTR [rsp+0x28],rcx
ffffffff80001231:	48 f7 d1             	not    rcx
ffffffff80001234:	31 d2                	xor    edx,edx
ffffffff80001236:	f3 48 0f bc d1       	tzcnt  rdx,rcx
ffffffff8000123b:	f3 4c 0f bc d8       	tzcnt  r11,rax
ffffffff80001240:	49 83 c3 40          	add    r11,0x40
ffffffff80001244:	48 85 c9             	test   rcx,rcx
ffffffff80001247:	4c 0f 45 da          	cmovne r11,rdx
ffffffff8000124b:	48 8b 6f 10          	mov    rbp,QWORD PTR [rdi+0x10]
ffffffff8000124f:	45 89 de             	mov    r14d,r11d
ffffffff80001252:	41 c1 e6 04          	shl    r14d,0x4
ffffffff80001256:	31 c0                	xor    eax,eax
ffffffff80001258:	31 d2                	xor    edx,edx
ffffffff8000125a:	31 c9                	xor    ecx,ecx
ffffffff8000125c:	31 db                	xor    ebx,ebx
ffffffff8000125e:	f0 4a 0f c7 4c 35 00 	lock cmpxchg16b OWORD PTR [rbp+r14*1+0x0]
ffffffff80001265:	49 89 c7             	mov    r15,rax
ffffffff80001268:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
ffffffff8000126d:	48 89 d0             	mov    rax,rdx
ffffffff80001270:	48 f7 d0             	not    rax
ffffffff80001273:	4c 89 f9             	mov    rcx,r15
ffffffff80001276:	48 f7 d1             	not    rcx
ffffffff80001279:	31 d2                	xor    edx,edx
ffffffff8000127b:	f3 48 0f bc d1       	tzcnt  rdx,rcx
ffffffff80001280:	31 f6                	xor    esi,esi
ffffffff80001282:	f3 48 0f bc f0       	tzcnt  rsi,rax
ffffffff80001287:	48 83 c6 40          	add    rsi,0x40
ffffffff8000128b:	48 85 c9             	test   rcx,rcx
ffffffff8000128e:	48 0f 45 f2          	cmovne rsi,rdx
ffffffff80001292:	b8 01 00 00 00       	mov    eax,0x1
ffffffff80001297:	45 31 d2             	xor    r10d,r10d
ffffffff8000129a:	89 f1                	mov    ecx,esi
ffffffff8000129c:	49 0f a5 c2          	shld   r10,rax,cl
ffffffff800012a0:	4d 01 ec             	add    r12,r13
ffffffff800012a3:	4d 8d 04 2e          	lea    r8,[r14+rbp*1]
ffffffff800012a7:	c4 62 c9 f7 e8       	shlx   r13,rax,rsi
ffffffff800012ac:	40 f6 c6 40          	test   sil,0x40
ffffffff800012b0:	4d 0f 45 d5          	cmovne r10,r13
ffffffff800012b4:	b8 00 00 00 00       	mov    eax,0x0
ffffffff800012b9:	4c 0f 45 e8          	cmovne r13,rax
ffffffff800012bd:	4a 8b 44 35 00       	mov    rax,QWORD PTR [rbp+r14*1+0x0]
ffffffff800012c2:	4a 8b 54 35 08       	mov    rdx,QWORD PTR [rbp+r14*1+0x8]
ffffffff800012c7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
ffffffff800012ce:	00 00 
ffffffff800012d0:	48 89 c3             	mov    rbx,rax
ffffffff800012d3:	4c 09 eb             	or     rbx,r13
ffffffff800012d6:	48 89 d1             	mov    rcx,rdx
ffffffff800012d9:	4c 09 d1             	or     rcx,r10
ffffffff800012dc:	f0 49 0f c7 08       	lock cmpxchg16b OWORD PTR [r8]
ffffffff800012e1:	75 ed                	jne    ffffffff800012d0 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x4b0>
ffffffff800012e3:	4d 09 fd             	or     r13,r15
ffffffff800012e6:	4c 0b 54 24 10       	or     r10,QWORD PTR [rsp+0x10]
ffffffff800012eb:	4d 21 ea             	and    r10,r13
ffffffff800012ee:	41 b8 01 00 00 00    	mov    r8d,0x1
ffffffff800012f4:	49 83 fa ff          	cmp    r10,0xffffffffffffffff
ffffffff800012f8:	0f 85 a8 00 00 00    	jne    ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff800012fe:	31 c0                	xor    eax,eax
ffffffff80001300:	ba 01 00 00 00       	mov    edx,0x1
ffffffff80001305:	45 31 d2             	xor    r10d,r10d
ffffffff80001308:	44 89 d9             	mov    ecx,r11d
ffffffff8000130b:	49 0f a5 d2          	shld   r10,rdx,cl
ffffffff8000130f:	c4 62 a1 f7 f2       	shlx   r14,rdx,r11
ffffffff80001314:	41 f6 c3 40          	test   r11b,0x40
ffffffff80001318:	4d 0f 45 d6          	cmovne r10,r14
ffffffff8000131c:	4c 0f 45 f0          	cmovne r14,rax
ffffffff80001320:	49 8b 04 24          	mov    rax,QWORD PTR [r12]
ffffffff80001324:	49 8b 54 24 08       	mov    rdx,QWORD PTR [r12+0x8]
ffffffff80001329:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
ffffffff80001330:	48 89 c3             	mov    rbx,rax
ffffffff80001333:	4c 09 f3             	or     rbx,r14
ffffffff80001336:	48 89 d1             	mov    rcx,rdx
ffffffff80001339:	4c 09 d1             	or     rcx,r10
ffffffff8000133c:	f0 49 0f c7 0c 24    	lock cmpxchg16b OWORD PTR [r12]
ffffffff80001342:	75 ec                	jne    ffffffff80001330 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x510>
ffffffff80001344:	4c 0b 74 24 28       	or     r14,QWORD PTR [rsp+0x28]
ffffffff80001349:	4c 0b 54 24 30       	or     r10,QWORD PTR [rsp+0x30]
ffffffff8000134e:	4d 21 f2             	and    r10,r14
ffffffff80001351:	49 83 fa ff          	cmp    r10,0xffffffffffffffff
ffffffff80001355:	75 4f                	jne    ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff80001357:	31 c0                	xor    eax,eax
ffffffff80001359:	ba 01 00 00 00       	mov    edx,0x1
ffffffff8000135e:	45 31 d2             	xor    r10d,r10d
ffffffff80001361:	44 89 c9             	mov    ecx,r9d
ffffffff80001364:	49 0f a5 d2          	shld   r10,rdx,cl
ffffffff80001368:	c4 62 b1 f7 da       	shlx   r11,rdx,r9
ffffffff8000136d:	41 f6 c1 40          	test   r9b,0x40
ffffffff80001371:	4d 0f 45 d3          	cmovne r10,r11
ffffffff80001375:	4c 0f 45 d8          	cmovne r11,rax
ffffffff80001379:	48 8b 47 20          	mov    rax,QWORD PTR [rdi+0x20]
ffffffff8000137d:	48 8b 57 28          	mov    rdx,QWORD PTR [rdi+0x28]
ffffffff80001381:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80001388:	0f 1f 84 00 00 00 00 
ffffffff8000138f:	00 
ffffffff80001390:	48 89 c3             	mov    rbx,rax
ffffffff80001393:	4c 09 db             	or     rbx,r11
ffffffff80001396:	48 89 d1             	mov    rcx,rdx
ffffffff80001399:	4c 09 d1             	or     rcx,r10
ffffffff8000139c:	f0 48 0f c7 4f 20    	lock cmpxchg16b OWORD PTR [rdi+0x20]
ffffffff800013a2:	75 ec                	jne    ffffffff80001390 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x570>
ffffffff800013a4:	eb 00                	jmp    ffffffff800013a6 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E+0x586>
ffffffff800013a6:	44 89 c0             	mov    eax,r8d
ffffffff800013a9:	89 f2                	mov    edx,esi
ffffffff800013ab:	48 83 c4 68          	add    rsp,0x68
ffffffff800013af:	5b                   	pop    rbx
ffffffff800013b0:	41 5c                	pop    r12
ffffffff800013b2:	41 5d                	pop    r13
ffffffff800013b4:	41 5e                	pop    r14
ffffffff800013b6:	41 5f                	pop    r15
ffffffff800013b8:	5d                   	pop    rbp
ffffffff800013b9:	c3                   	ret    
ffffffff800013ba:	48 8d 35 67 4c 01 00 	lea    rsi,[rip+0x14c67]        # ffffffff80016028 <memset+0x12848>
ffffffff800013c1:	bf 80 00 00 00       	mov    edi,0x80
ffffffff800013c6:	e8 75 0e 00 00       	call   ffffffff80002240 <_ZN4core9panicking18panic_bounds_check17h4a57ffaa181cea47E>
ffffffff800013cb:	48 8d 35 1e 4c 01 00 	lea    rsi,[rip+0x14c1e]        # ffffffff80015ff0 <memset+0x12810>
ffffffff800013d2:	4c 89 e7             	mov    rdi,r12
ffffffff800013d5:	e8 66 0e 00 00       	call   ffffffff80002240 <_ZN4core9panicking18panic_bounds_check17h4a57ffaa181cea47E>
ffffffff800013da:	cc                   	int3   
ffffffff800013db:	cc                   	int3   
ffffffff800013dc:	cc                   	int3   
ffffffff800013dd:	cc                   	int3   
ffffffff800013de:	cc                   	int3   
ffffffff800013df:	cc                   	int3   

ffffffff800013e0 <_start>:
ffffffff800013e0:	55                   	push   rbp
ffffffff800013e1:	41 57                	push   r15
ffffffff800013e3:	41 56                	push   r14
ffffffff800013e5:	41 55                	push   r13
ffffffff800013e7:	41 54                	push   r12
ffffffff800013e9:	53                   	push   rbx
ffffffff800013ea:	48 81 ec 88 08 00 00 	sub    rsp,0x888
ffffffff800013f1:	fa                   	cli    
ffffffff800013f2:	48 83 3d 7e 4c 01 00 	cmp    QWORD PTR [rip+0x14c7e],0x0        # ffffffff80016078 <_ZN6kernel13BASE_REVISION17h82e03dd983589742E+0x10>
ffffffff800013f9:	00 
ffffffff800013fa:	0f 85 60 07 00 00    	jne    ffffffff80001b60 <_start+0x780>
ffffffff80001400:	48 83 3d a0 4c 01 00 	cmp    QWORD PTR [rip+0x14ca0],0x0        # ffffffff800160a8 <_ZN6kernel12HHDM_REQUEST17he647807069b1b72aE+0x28>
ffffffff80001407:	00 
ffffffff80001408:	0f 84 57 07 00 00    	je     ffffffff80001b65 <_start+0x785>
ffffffff8000140e:	48 8b 0d c3 4c 01 00 	mov    rcx,QWORD PTR [rip+0x14cc3]        # ffffffff800160d8 <_ZN6kernel19FRAMEBUFFER_REQUEST17h58c045424294434eE+0x28>
ffffffff80001415:	48 85 c9             	test   rcx,rcx
ffffffff80001418:	74 44                	je     ffffffff8000145e <_start+0x7e>
ffffffff8000141a:	48 8b 41 08          	mov    rax,QWORD PTR [rcx+0x8]
ffffffff8000141e:	48 8b 51 10          	mov    rdx,QWORD PTR [rcx+0x10]
ffffffff80001422:	48 c1 e0 03          	shl    rax,0x3
ffffffff80001426:	31 c9                	xor    ecx,ecx
ffffffff80001428:	31 f6                	xor    esi,esi
ffffffff8000142a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
ffffffff80001430:	48 39 f0             	cmp    rax,rsi
ffffffff80001433:	74 2b                	je     ffffffff80001460 <_start+0x80>
ffffffff80001435:	4c 8b 14 32          	mov    r10,QWORD PTR [rdx+rsi*1]
ffffffff80001439:	48 83 c6 08          	add    rsi,0x8
ffffffff8000143d:	4d 85 d2             	test   r10,r10
ffffffff80001440:	74 ee                	je     ffffffff80001430 <_start+0x50>
ffffffff80001442:	41 80 7a 22 01       	cmp    BYTE PTR [r10+0x22],0x1
ffffffff80001447:	75 e7                	jne    ffffffff80001430 <_start+0x50>
ffffffff80001449:	66 41 83 7a 20 20    	cmp    WORD PTR [r10+0x20],0x20
ffffffff8000144f:	75 df                	jne    ffffffff80001430 <_start+0x50>
ffffffff80001451:	4d 8b 0a             	mov    r9,QWORD PTR [r10]
ffffffff80001454:	41 f6 c1 03          	test   r9b,0x3
ffffffff80001458:	0f 84 c5 06 00 00    	je     ffffffff80001b23 <_start+0x743>
ffffffff8000145e:	31 c9                	xor    ecx,ecx
ffffffff80001460:	b3 01                	mov    bl,0x1
ffffffff80001462:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80001469:	1f 84 00 00 00 00 00 
ffffffff80001470:	31 c0                	xor    eax,eax
ffffffff80001472:	f0 0f b0 1d be 4e 01 	lock cmpxchg BYTE PTR [rip+0x14ebe],bl        # ffffffff80016338 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E>
ffffffff80001479:	00 
ffffffff8000147a:	74 1e                	je     ffffffff8000149a <_start+0xba>
ffffffff8000147c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
ffffffff80001480:	0f b6 05 b1 4e 01 00 	movzx  eax,BYTE PTR [rip+0x14eb1]        # ffffffff80016338 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E>
ffffffff80001487:	84 c0                	test   al,al
ffffffff80001489:	74 e5                	je     ffffffff80001470 <_start+0x90>
ffffffff8000148b:	f3 90                	pause  
ffffffff8000148d:	0f b6 05 a4 4e 01 00 	movzx  eax,BYTE PTR [rip+0x14ea4]        # ffffffff80016338 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E>
ffffffff80001494:	84 c0                	test   al,al
ffffffff80001496:	75 f3                	jne    ffffffff8000148b <_start+0xab>
ffffffff80001498:	eb d6                	jmp    ffffffff80001470 <_start+0x90>
ffffffff8000149a:	48 89 0d 9f 4e 01 00 	mov    QWORD PTR [rip+0x14e9f],rcx        # ffffffff80016340 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x8>
ffffffff800014a1:	4c 89 0d a0 4e 01 00 	mov    QWORD PTR [rip+0x14ea0],r9        # ffffffff80016348 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x10>
ffffffff800014a8:	4c 89 1d a1 4e 01 00 	mov    QWORD PTR [rip+0x14ea1],r11        # ffffffff80016350 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x18>
ffffffff800014af:	4c 89 15 a2 4e 01 00 	mov    QWORD PTR [rip+0x14ea2],r10        # ffffffff80016358 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x20>
ffffffff800014b6:	4c 89 05 a3 4e 01 00 	mov    QWORD PTR [rip+0x14ea3],r8        # ffffffff80016360 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x28>
ffffffff800014bd:	48 8b 84 24 80 00 00 	mov    rax,QWORD PTR [rsp+0x80]
ffffffff800014c4:	00 
ffffffff800014c5:	48 8b 8c 24 88 00 00 	mov    rcx,QWORD PTR [rsp+0x88]
ffffffff800014cc:	00 
ffffffff800014cd:	48 89 05 94 4e 01 00 	mov    QWORD PTR [rip+0x14e94],rax        # ffffffff80016368 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x30>
ffffffff800014d4:	48 89 0d 95 4e 01 00 	mov    QWORD PTR [rip+0x14e95],rcx        # ffffffff80016370 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x38>
ffffffff800014db:	40 88 3d 96 4e 01 00 	mov    BYTE PTR [rip+0x14e96],dil        # ffffffff80016378 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x40>
ffffffff800014e2:	40 88 35 90 4e 01 00 	mov    BYTE PTR [rip+0x14e90],sil        # ffffffff80016379 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x41>
ffffffff800014e9:	88 15 8b 4e 01 00    	mov    BYTE PTR [rip+0x14e8b],dl        # ffffffff8001637a <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x42>
ffffffff800014ef:	8b 44 24 20          	mov    eax,DWORD PTR [rsp+0x20]
ffffffff800014f3:	89 05 82 4e 01 00    	mov    DWORD PTR [rip+0x14e82],eax        # ffffffff8001637b <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x43>
ffffffff800014f9:	0f b6 44 24 24       	movzx  eax,BYTE PTR [rsp+0x24]
ffffffff800014fe:	88 05 7b 4e 01 00    	mov    BYTE PTR [rip+0x14e7b],al        # ffffffff8001637f <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E+0x47>
ffffffff80001504:	c6 05 2d 4e 01 00 00 	mov    BYTE PTR [rip+0x14e2d],0x0        # ffffffff80016338 <_ZN6kernel11debug_print13DEBUG_PRINTER17hae0a855f55ce9545E>
ffffffff8000150b:	48 8d 1d b6 0f 01 00 	lea    rbx,[rip+0x10fb6]        # ffffffff800124c8 <memset+0xece8>
ffffffff80001512:	48 89 5c 24 20       	mov    QWORD PTR [rsp+0x20],rbx
ffffffff80001517:	48 8d 2d 72 19 00 00 	lea    rbp,[rip+0x1972]        # ffffffff80002e90 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h5edd5340cb38599eE>
ffffffff8000151e:	48 89 6c 24 28       	mov    QWORD PTR [rsp+0x28],rbp
ffffffff80001523:	48 8d 05 fe 4b 01 00 	lea    rax,[rip+0x14bfe]        # ffffffff80016128 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x48>
ffffffff8000152a:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001531:	00 
ffffffff80001532:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x2
ffffffff80001539:	00 02 00 00 00 
ffffffff8000153e:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001545:	00 00 00 00 00 
ffffffff8000154a:	4c 8d 74 24 20       	lea    r14,[rsp+0x20]
ffffffff8000154f:	4c 89 b4 24 90 00 00 	mov    QWORD PTR [rsp+0x90],r14
ffffffff80001556:	00 
ffffffff80001557:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x1
ffffffff8000155e:	00 01 00 00 00 
ffffffff80001563:	4c 8d 3d 2e 0f 01 00 	lea    r15,[rip+0x10f2e]        # ffffffff80012498 <memset+0xecb8>
ffffffff8000156a:	49 89 e4             	mov    r12,rsp
ffffffff8000156d:	48 8d 94 24 80 00 00 	lea    rdx,[rsp+0x80]
ffffffff80001574:	00 
ffffffff80001575:	4c 89 e7             	mov    rdi,r12
ffffffff80001578:	4c 89 fe             	mov    rsi,r15
ffffffff8000157b:	e8 30 19 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80001580:	48 89 5c 24 20       	mov    QWORD PTR [rsp+0x20],rbx
ffffffff80001585:	48 89 6c 24 28       	mov    QWORD PTR [rsp+0x28],rbp
ffffffff8000158a:	48 8d 05 47 0f 01 00 	lea    rax,[rip+0x10f47]        # ffffffff800124d8 <memset+0xecf8>
ffffffff80001591:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001598:	00 
ffffffff80001599:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x2
ffffffff800015a0:	00 02 00 00 00 
ffffffff800015a5:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff800015ac:	00 00 00 00 00 
ffffffff800015b1:	4c 89 b4 24 90 00 00 	mov    QWORD PTR [rsp+0x90],r14
ffffffff800015b8:	00 
ffffffff800015b9:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x1
ffffffff800015c0:	00 01 00 00 00 
ffffffff800015c5:	48 8d 94 24 80 00 00 	lea    rdx,[rsp+0x80]
ffffffff800015cc:	00 
ffffffff800015cd:	4c 89 e7             	mov    rdi,r12
ffffffff800015d0:	4c 89 fe             	mov    rsi,r15
ffffffff800015d3:	e8 d8 18 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff800015d8:	31 c0                	xor    eax,eax
ffffffff800015da:	31 c9                	xor    ecx,ecx
ffffffff800015dc:	49 89 d8             	mov    r8,rbx
ffffffff800015df:	0f a2                	cpuid  
ffffffff800015e1:	4c 87 c3             	xchg   rbx,r8
ffffffff800015e4:	89 ce                	mov    esi,ecx
ffffffff800015e6:	89 d7                	mov    edi,edx
ffffffff800015e8:	41 89 c6             	mov    r14d,eax
ffffffff800015eb:	b8 00 00 00 80       	mov    eax,0x80000000
ffffffff800015f0:	31 c9                	xor    ecx,ecx
ffffffff800015f2:	49 89 d9             	mov    r9,rbx
ffffffff800015f5:	0f a2                	cpuid  
ffffffff800015f7:	4c 87 cb             	xchg   rbx,r9
ffffffff800015fa:	41 89 c5             	mov    r13d,eax
ffffffff800015fd:	44 89 44 24 20       	mov    DWORD PTR [rsp+0x20],r8d
ffffffff80001602:	89 7c 24 24          	mov    DWORD PTR [rsp+0x24],edi
ffffffff80001606:	89 74 24 28          	mov    DWORD PTR [rsp+0x28],esi
ffffffff8000160a:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001611:	00 
ffffffff80001612:	48 8d 5c 24 20       	lea    rbx,[rsp+0x20]
ffffffff80001617:	48 89 de             	mov    rsi,rbx
ffffffff8000161a:	e8 d1 1b 00 00       	call   ffffffff800031f0 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E>
ffffffff8000161f:	48 8d 05 d2 0e 01 00 	lea    rax,[rip+0x10ed2]        # ffffffff800124f8 <memset+0xed18>
ffffffff80001626:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff8000162b:	48 89 6c 24 28       	mov    QWORD PTR [rsp+0x28],rbp
ffffffff80001630:	48 8d 05 d1 0e 01 00 	lea    rax,[rip+0x10ed1]        # ffffffff80012508 <memset+0xed28>
ffffffff80001637:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff8000163e:	00 
ffffffff8000163f:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x2
ffffffff80001646:	00 02 00 00 00 
ffffffff8000164b:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001652:	00 00 00 00 00 
ffffffff80001657:	48 89 9c 24 90 00 00 	mov    QWORD PTR [rsp+0x90],rbx
ffffffff8000165e:	00 
ffffffff8000165f:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x1
ffffffff80001666:	00 01 00 00 00 
ffffffff8000166b:	48 8d 94 24 80 00 00 	lea    rdx,[rsp+0x80]
ffffffff80001672:	00 
ffffffff80001673:	4c 89 e7             	mov    rdi,r12
ffffffff80001676:	4c 89 fe             	mov    rsi,r15
ffffffff80001679:	e8 32 18 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff8000167e:	31 c9                	xor    ecx,ecx
ffffffff80001680:	31 c0                	xor    eax,eax
ffffffff80001682:	48 89 de             	mov    rsi,rbx
ffffffff80001685:	0f a2                	cpuid  
ffffffff80001687:	48 87 f3             	xchg   rbx,rsi
ffffffff8000168a:	89 74 24 10          	mov    DWORD PTR [rsp+0x10],esi
ffffffff8000168e:	89 54 24 14          	mov    DWORD PTR [rsp+0x14],edx
ffffffff80001692:	89 4c 24 18          	mov    DWORD PTR [rsp+0x18],ecx
ffffffff80001696:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff8000169d:	00 
ffffffff8000169e:	48 8d 74 24 10       	lea    rsi,[rsp+0x10]
ffffffff800016a3:	e8 48 1b 00 00       	call   ffffffff800031f0 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E>
ffffffff800016a8:	48 83 bc 24 80 00 00 	cmp    QWORD PTR [rsp+0x80],0x0
ffffffff800016af:	00 00 
ffffffff800016b1:	b8 13 00 00 00       	mov    eax,0x13
ffffffff800016b6:	48 0f 44 84 24 90 00 	cmove  rax,QWORD PTR [rsp+0x90]
ffffffff800016bd:	00 00 
ffffffff800016bf:	48 8d 0d b0 4f 00 00 	lea    rcx,[rip+0x4fb0]        # ffffffff80006676 <memset+0x2e96>
ffffffff800016c6:	48 0f 44 8c 24 88 00 	cmove  rcx,QWORD PTR [rsp+0x88]
ffffffff800016cd:	00 00 
ffffffff800016cf:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
ffffffff800016d4:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
ffffffff800016d9:	48 89 5c 24 50       	mov    QWORD PTR [rsp+0x50],rbx
ffffffff800016de:	48 89 6c 24 58       	mov    QWORD PTR [rsp+0x58],rbp
ffffffff800016e3:	48 8d 05 3e 0e 01 00 	lea    rax,[rip+0x10e3e]        # ffffffff80012528 <memset+0xed48>
ffffffff800016ea:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff800016f1:	00 
ffffffff800016f2:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x2
ffffffff800016f9:	00 02 00 00 00 
ffffffff800016fe:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001705:	00 00 00 00 00 
ffffffff8000170a:	48 8d 44 24 50       	lea    rax,[rsp+0x50]
ffffffff8000170f:	48 89 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],rax
ffffffff80001716:	00 
ffffffff80001717:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x1
ffffffff8000171e:	00 01 00 00 00 
ffffffff80001723:	48 8d 94 24 80 00 00 	lea    rdx,[rsp+0x80]
ffffffff8000172a:	00 
ffffffff8000172b:	4c 89 e7             	mov    rdi,r12
ffffffff8000172e:	4c 89 fe             	mov    rsi,r15
ffffffff80001731:	e8 7a 17 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80001736:	45 85 f6             	test   r14d,r14d
ffffffff80001739:	0f 84 3e 04 00 00    	je     ffffffff80001b7d <_start+0x79d>
ffffffff8000173f:	31 c9                	xor    ecx,ecx
ffffffff80001741:	b8 01 00 00 00       	mov    eax,0x1
ffffffff80001746:	48 89 de             	mov    rsi,rbx
ffffffff80001749:	0f a2                	cpuid  
ffffffff8000174b:	48 87 f3             	xchg   rbx,rsi
ffffffff8000174e:	41 83 fe 06          	cmp    r14d,0x6
ffffffff80001752:	0f 86 3d 04 00 00    	jbe    ffffffff80001b95 <_start+0x7b5>
ffffffff80001758:	89 d6                	mov    esi,edx
ffffffff8000175a:	89 cf                	mov    edi,ecx
ffffffff8000175c:	31 c9                	xor    ecx,ecx
ffffffff8000175e:	b8 07 00 00 00       	mov    eax,0x7
ffffffff80001763:	49 89 da             	mov    r10,rbx
ffffffff80001766:	0f a2                	cpuid  
ffffffff80001768:	4c 87 d3             	xchg   rbx,r10
ffffffff8000176b:	41 81 fd 01 00 00 80 	cmp    r13d,0x80000001
ffffffff80001772:	0f 82 35 04 00 00    	jb     ffffffff80001bad <_start+0x7cd>
ffffffff80001778:	41 89 f9             	mov    r9d,edi
ffffffff8000177b:	b8 01 00 00 80       	mov    eax,0x80000001
ffffffff80001780:	31 c9                	xor    ecx,ecx
ffffffff80001782:	48 89 df             	mov    rdi,rbx
ffffffff80001785:	0f a2                	cpuid  
ffffffff80001787:	48 87 fb             	xchg   rbx,rdi
ffffffff8000178a:	89 d7                	mov    edi,edx
ffffffff8000178c:	41 89 c8             	mov    r8d,ecx
ffffffff8000178f:	31 c9                	xor    ecx,ecx
ffffffff80001791:	b8 06 00 00 00       	mov    eax,0x6
ffffffff80001796:	49 89 db             	mov    r11,rbx
ffffffff80001799:	0f a2                	cpuid  
ffffffff8000179b:	4c 87 db             	xchg   rbx,r11
ffffffff8000179e:	41 f7 c1 00 00 00 10 	test   r9d,0x10000000
ffffffff800017a5:	0f 84 1a 04 00 00    	je     ffffffff80001bc5 <_start+0x7e5>
ffffffff800017ab:	41 f6 c2 20          	test   r10b,0x20
ffffffff800017af:	0f 84 63 04 00 00    	je     ffffffff80001c18 <_start+0x838>
ffffffff800017b5:	41 f6 c2 08          	test   r10b,0x8
ffffffff800017b9:	0f 84 ac 04 00 00    	je     ffffffff80001c6b <_start+0x88b>
ffffffff800017bf:	41 f7 c2 00 01 00 00 	test   r10d,0x100
ffffffff800017c6:	0f 84 f2 04 00 00    	je     ffffffff80001cbe <_start+0x8de>
ffffffff800017cc:	41 f7 c1 00 00 00 20 	test   r9d,0x20000000
ffffffff800017d3:	0f 84 38 05 00 00    	je     ffffffff80001d11 <_start+0x931>
ffffffff800017d9:	41 f7 c1 00 10 00 00 	test   r9d,0x1000
ffffffff800017e0:	0f 84 7e 05 00 00    	je     ffffffff80001d64 <_start+0x984>
ffffffff800017e6:	41 f6 c0 20          	test   r8b,0x20
ffffffff800017ea:	0f 84 c7 05 00 00    	je     ffffffff80001db7 <_start+0x9d7>
ffffffff800017f0:	41 f7 c1 00 00 40 00 	test   r9d,0x400000
ffffffff800017f7:	0f 84 0d 06 00 00    	je     ffffffff80001e0a <_start+0xa2a>
ffffffff800017fd:	41 f7 c1 00 00 00 04 	test   r9d,0x4000000
ffffffff80001804:	0f 84 53 06 00 00    	je     ffffffff80001e5d <_start+0xa7d>
ffffffff8000180a:	f7 c6 00 02 00 00    	test   esi,0x200
ffffffff80001810:	0f 84 9a 06 00 00    	je     ffffffff80001eb0 <_start+0xad0>
ffffffff80001816:	a8 04                	test   al,0x4
ffffffff80001818:	0f 84 e5 06 00 00    	je     ffffffff80001f03 <_start+0xb23>
ffffffff8000181e:	f7 c7 00 00 00 04    	test   edi,0x4000000
ffffffff80001824:	0f 84 2c 07 00 00    	je     ffffffff80001f56 <_start+0xb76>
ffffffff8000182a:	48 8d 05 c7 0c 01 00 	lea    rax,[rip+0x10cc7]        # ffffffff800124f8 <memset+0xed18>
ffffffff80001831:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff80001836:	48 8d 05 53 16 00 00 	lea    rax,[rip+0x1653]        # ffffffff80002e90 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h5edd5340cb38599eE>
ffffffff8000183d:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
ffffffff80001842:	48 8d 05 47 0d 01 00 	lea    rax,[rip+0x10d47]        # ffffffff80012590 <memset+0xedb0>
ffffffff80001849:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001850:	00 
ffffffff80001851:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x2
ffffffff80001858:	00 02 00 00 00 
ffffffff8000185d:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001864:	00 00 00 00 00 
ffffffff80001869:	48 8d 44 24 20       	lea    rax,[rsp+0x20]
ffffffff8000186e:	48 89 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],rax
ffffffff80001875:	00 
ffffffff80001876:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x1
ffffffff8000187d:	00 01 00 00 00 
ffffffff80001882:	48 8d 35 0f 0c 01 00 	lea    rsi,[rip+0x10c0f]        # ffffffff80012498 <memset+0xecb8>
ffffffff80001889:	48 89 e7             	mov    rdi,rsp
ffffffff8000188c:	4c 8d b4 24 80 00 00 	lea    r14,[rsp+0x80]
ffffffff80001893:	00 
ffffffff80001894:	4c 89 f2             	mov    rdx,r14
ffffffff80001897:	e8 14 16 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff8000189c:	48 83 3d 64 48 01 00 	cmp    QWORD PTR [rip+0x14864],0x0        # ffffffff80016108 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x28>
ffffffff800018a3:	00 
ffffffff800018a4:	0f 84 ff 06 00 00    	je     ffffffff80001fa9 <_start+0xbc9>
ffffffff800018aa:	ba 00 08 00 00       	mov    edx,0x800
ffffffff800018af:	4c 89 f7             	mov    rdi,r14
ffffffff800018b2:	31 f6                	xor    esi,esi
ffffffff800018b4:	ff 15 76 4a 01 00    	call   QWORD PTR [rip+0x14a76]        # ffffffff80016330 <_DYNAMIC+0xe8>
ffffffff800018ba:	48 c7 44 24 68 00 00 	mov    QWORD PTR [rsp+0x68],0x0
ffffffff800018c1:	00 00 
ffffffff800018c3:	48 c7 44 24 60 00 00 	mov    QWORD PTR [rsp+0x60],0x0
ffffffff800018ca:	00 00 
ffffffff800018cc:	4c 89 74 24 58       	mov    QWORD PTR [rsp+0x58],r14
ffffffff800018d1:	48 c7 44 24 50 00 00 	mov    QWORD PTR [rsp+0x50],0x0
ffffffff800018d8:	00 00 
ffffffff800018da:	41 be 80 00 00 00    	mov    r14d,0x80
ffffffff800018e0:	4c 8d 7c 24 50       	lea    r15,[rsp+0x50]
ffffffff800018e5:	48 8d 5c 24 08       	lea    rbx,[rsp+0x8]
ffffffff800018ea:	4c 8d 25 a7 0b 01 00 	lea    r12,[rip+0x10ba7]        # ffffffff80012498 <memset+0xecb8>
ffffffff800018f1:	4c 8d 6c 24 20       	lea    r13,[rsp+0x20]
ffffffff800018f6:	48 8d 2d 2b 0c 01 00 	lea    rbp,[rip+0x10c2b]        # ffffffff80012528 <memset+0xed48>
ffffffff800018fd:	0f 1f 00             	nop    DWORD PTR [rax]
ffffffff80001900:	4c 89 ff             	mov    rdi,r15
ffffffff80001903:	e8 18 f5 ff ff       	call   ffffffff80000e20 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E>
ffffffff80001908:	89 44 24 08          	mov    DWORD PTR [rsp+0x8],eax
ffffffff8000190c:	89 54 24 0c          	mov    DWORD PTR [rsp+0xc],edx
ffffffff80001910:	48 89 5c 24 10       	mov    QWORD PTR [rsp+0x10],rbx
ffffffff80001915:	48 8d 05 84 ea ff ff 	lea    rax,[rip+0xffffffffffffea84]        # ffffffff800003a0 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E>
ffffffff8000191c:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff80001921:	48 89 6c 24 20       	mov    QWORD PTR [rsp+0x20],rbp
ffffffff80001926:	48 c7 44 24 28 02 00 	mov    QWORD PTR [rsp+0x28],0x2
ffffffff8000192d:	00 00 
ffffffff8000192f:	48 c7 44 24 40 00 00 	mov    QWORD PTR [rsp+0x40],0x0
ffffffff80001936:	00 00 
ffffffff80001938:	48 8d 44 24 10       	lea    rax,[rsp+0x10]
ffffffff8000193d:	48 89 44 24 30       	mov    QWORD PTR [rsp+0x30],rax
ffffffff80001942:	48 c7 44 24 38 01 00 	mov    QWORD PTR [rsp+0x38],0x1
ffffffff80001949:	00 00 
ffffffff8000194b:	48 89 e7             	mov    rdi,rsp
ffffffff8000194e:	4c 89 e6             	mov    rsi,r12
ffffffff80001951:	4c 89 ea             	mov    rdx,r13
ffffffff80001954:	e8 57 15 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80001959:	41 ff ce             	dec    r14d
ffffffff8000195c:	75 a2                	jne    ffffffff80001900 <_start+0x520>
ffffffff8000195e:	48 8d 7c 24 50       	lea    rdi,[rsp+0x50]
ffffffff80001963:	49 89 fc             	mov    r12,rdi
ffffffff80001966:	e8 b5 f4 ff ff       	call   ffffffff80000e20 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E>
ffffffff8000196b:	89 44 24 08          	mov    DWORD PTR [rsp+0x8],eax
ffffffff8000196f:	89 54 24 0c          	mov    DWORD PTR [rsp+0xc],edx
ffffffff80001973:	48 89 5c 24 10       	mov    QWORD PTR [rsp+0x10],rbx
ffffffff80001978:	49 89 df             	mov    r15,rbx
ffffffff8000197b:	48 8d 1d 1e ea ff ff 	lea    rbx,[rip+0xffffffffffffea1e]        # ffffffff800003a0 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E>
ffffffff80001982:	48 89 5c 24 18       	mov    QWORD PTR [rsp+0x18],rbx
ffffffff80001987:	48 89 6c 24 20       	mov    QWORD PTR [rsp+0x20],rbp
ffffffff8000198c:	48 c7 44 24 28 02 00 	mov    QWORD PTR [rsp+0x28],0x2
ffffffff80001993:	00 00 
ffffffff80001995:	48 c7 44 24 40 00 00 	mov    QWORD PTR [rsp+0x40],0x0
ffffffff8000199c:	00 00 
ffffffff8000199e:	4c 8d 6c 24 10       	lea    r13,[rsp+0x10]
ffffffff800019a3:	4c 89 6c 24 30       	mov    QWORD PTR [rsp+0x30],r13
ffffffff800019a8:	48 c7 44 24 38 01 00 	mov    QWORD PTR [rsp+0x38],0x1
ffffffff800019af:	00 00 
ffffffff800019b1:	48 8d 35 e0 0a 01 00 	lea    rsi,[rip+0x10ae0]        # ffffffff80012498 <memset+0xecb8>
ffffffff800019b8:	4c 8d 6c 24 20       	lea    r13,[rsp+0x20]
ffffffff800019bd:	49 89 e6             	mov    r14,rsp
ffffffff800019c0:	4c 89 f7             	mov    rdi,r14
ffffffff800019c3:	4c 89 ea             	mov    rdx,r13
ffffffff800019c6:	e8 e5 14 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff800019cb:	4c 89 e3             	mov    rbx,r12
ffffffff800019ce:	4c 89 e7             	mov    rdi,r12
ffffffff800019d1:	e8 4a f4 ff ff       	call   ffffffff80000e20 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E>
ffffffff800019d6:	89 44 24 08          	mov    DWORD PTR [rsp+0x8],eax
ffffffff800019da:	89 54 24 0c          	mov    DWORD PTR [rsp+0xc],edx
ffffffff800019de:	4c 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],r15
ffffffff800019e3:	4c 8d 25 b6 e9 ff ff 	lea    r12,[rip+0xffffffffffffe9b6]        # ffffffff800003a0 <_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hd00be156e0e543c8E>
ffffffff800019ea:	4c 89 64 24 18       	mov    QWORD PTR [rsp+0x18],r12
ffffffff800019ef:	48 89 6c 24 20       	mov    QWORD PTR [rsp+0x20],rbp
ffffffff800019f4:	48 c7 44 24 28 02 00 	mov    QWORD PTR [rsp+0x28],0x2
ffffffff800019fb:	00 00 
ffffffff800019fd:	48 c7 44 24 40 00 00 	mov    QWORD PTR [rsp+0x40],0x0
ffffffff80001a04:	00 00 
ffffffff80001a06:	4c 8d 7c 24 10       	lea    r15,[rsp+0x10]
ffffffff80001a0b:	4c 89 7c 24 30       	mov    QWORD PTR [rsp+0x30],r15
ffffffff80001a10:	48 c7 44 24 38 01 00 	mov    QWORD PTR [rsp+0x38],0x1
ffffffff80001a17:	00 00 
ffffffff80001a19:	4c 89 f7             	mov    rdi,r14
ffffffff80001a1c:	48 8d 35 75 0a 01 00 	lea    rsi,[rip+0x10a75]        # ffffffff80012498 <memset+0xecb8>
ffffffff80001a23:	4c 89 ea             	mov    rdx,r13
ffffffff80001a26:	e8 85 14 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80001a2b:	48 89 df             	mov    rdi,rbx
ffffffff80001a2e:	e8 ed f3 ff ff       	call   ffffffff80000e20 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E>
ffffffff80001a33:	89 44 24 08          	mov    DWORD PTR [rsp+0x8],eax
ffffffff80001a37:	89 54 24 0c          	mov    DWORD PTR [rsp+0xc],edx
ffffffff80001a3b:	48 8d 44 24 08       	lea    rax,[rsp+0x8]
ffffffff80001a40:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff80001a45:	4c 89 64 24 18       	mov    QWORD PTR [rsp+0x18],r12
ffffffff80001a4a:	48 89 6c 24 20       	mov    QWORD PTR [rsp+0x20],rbp
ffffffff80001a4f:	48 c7 44 24 28 02 00 	mov    QWORD PTR [rsp+0x28],0x2
ffffffff80001a56:	00 00 
ffffffff80001a58:	48 c7 44 24 40 00 00 	mov    QWORD PTR [rsp+0x40],0x0
ffffffff80001a5f:	00 00 
ffffffff80001a61:	4c 89 7c 24 30       	mov    QWORD PTR [rsp+0x30],r15
ffffffff80001a66:	48 c7 44 24 38 01 00 	mov    QWORD PTR [rsp+0x38],0x1
ffffffff80001a6d:	00 00 
ffffffff80001a6f:	4c 89 f7             	mov    rdi,r14
ffffffff80001a72:	48 8d 35 1f 0a 01 00 	lea    rsi,[rip+0x10a1f]        # ffffffff80012498 <memset+0xecb8>
ffffffff80001a79:	4c 89 ea             	mov    rdx,r13
ffffffff80001a7c:	e8 2f 14 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80001a81:	48 89 df             	mov    rdi,rbx
ffffffff80001a84:	e8 97 f3 ff ff       	call   ffffffff80000e20 <_ZN6kernel3mem5Alloc5alloc17h6a7e63bea80b7f46E>
ffffffff80001a89:	89 44 24 08          	mov    DWORD PTR [rsp+0x8],eax
ffffffff80001a8d:	89 54 24 0c          	mov    DWORD PTR [rsp+0xc],edx
ffffffff80001a91:	48 8d 44 24 08       	lea    rax,[rsp+0x8]
ffffffff80001a96:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff80001a9b:	4c 89 64 24 18       	mov    QWORD PTR [rsp+0x18],r12
ffffffff80001aa0:	48 89 6c 24 20       	mov    QWORD PTR [rsp+0x20],rbp
ffffffff80001aa5:	48 c7 44 24 28 02 00 	mov    QWORD PTR [rsp+0x28],0x2
ffffffff80001aac:	00 00 
ffffffff80001aae:	48 c7 44 24 40 00 00 	mov    QWORD PTR [rsp+0x40],0x0
ffffffff80001ab5:	00 00 
ffffffff80001ab7:	4c 89 7c 24 30       	mov    QWORD PTR [rsp+0x30],r15
ffffffff80001abc:	48 c7 44 24 38 01 00 	mov    QWORD PTR [rsp+0x38],0x1
ffffffff80001ac3:	00 00 
ffffffff80001ac5:	4c 89 f7             	mov    rdi,r14
ffffffff80001ac8:	48 8d 1d c9 09 01 00 	lea    rbx,[rip+0x109c9]        # ffffffff80012498 <memset+0xecb8>
ffffffff80001acf:	48 89 de             	mov    rsi,rbx
ffffffff80001ad2:	4c 89 ea             	mov    rdx,r13
ffffffff80001ad5:	e8 d6 13 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80001ada:	48 8d 05 77 45 01 00 	lea    rax,[rip+0x14577]        # ffffffff80016058 <memset+0x12878>
ffffffff80001ae1:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff80001ae6:	48 c7 44 24 28 01 00 	mov    QWORD PTR [rsp+0x28],0x1
ffffffff80001aed:	00 00 
ffffffff80001aef:	48 c7 44 24 40 00 00 	mov    QWORD PTR [rsp+0x40],0x0
ffffffff80001af6:	00 00 
ffffffff80001af8:	4c 89 74 24 30       	mov    QWORD PTR [rsp+0x30],r14
ffffffff80001afd:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
ffffffff80001b04:	00 00 
ffffffff80001b06:	48 8d 54 24 20       	lea    rdx,[rsp+0x20]
ffffffff80001b0b:	4c 89 f7             	mov    rdi,r14
ffffffff80001b0e:	48 89 de             	mov    rsi,rbx
ffffffff80001b11:	e8 9a 13 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80001b16:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80001b1d:	00 00 00 
ffffffff80001b20:	f4                   	hlt    
ffffffff80001b21:	eb fd                	jmp    ffffffff80001b20 <_start+0x740>
ffffffff80001b23:	41 0f b6 52 28       	movzx  edx,BYTE PTR [r10+0x28]
ffffffff80001b28:	41 0f b6 72 26       	movzx  esi,BYTE PTR [r10+0x26]
ffffffff80001b2d:	41 0f b6 7a 24       	movzx  edi,BYTE PTR [r10+0x24]
ffffffff80001b32:	4d 8b 42 18          	mov    r8,QWORD PTR [r10+0x18]
ffffffff80001b36:	4d 8b 5a 08          	mov    r11,QWORD PTR [r10+0x8]
ffffffff80001b3a:	4d 8b 52 10          	mov    r10,QWORD PTR [r10+0x10]
ffffffff80001b3e:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x0
ffffffff80001b45:	00 00 00 00 00 
ffffffff80001b4a:	48 c7 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],0x0
ffffffff80001b51:	00 00 00 00 00 
ffffffff80001b56:	b9 01 00 00 00       	mov    ecx,0x1
ffffffff80001b5b:	e9 00 f9 ff ff       	jmp    ffffffff80001460 <_start+0x80>
ffffffff80001b60:	e8 cb 12 00 00       	call   ffffffff80002e30 <_ZN4core9panicking5panic17h46e4bc2a84108c31E>
ffffffff80001b65:	48 8d 3d c3 47 00 00 	lea    rdi,[rip+0x47c3]        # ffffffff8000632f <memset+0x2b4f>
ffffffff80001b6c:	48 8d 15 9d 45 01 00 	lea    rdx,[rip+0x1459d]        # ffffffff80016110 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x30>
ffffffff80001b73:	be 2b 00 00 00       	mov    esi,0x2b
ffffffff80001b78:	e8 63 1b 00 00       	call   ffffffff800036e0 <_ZN4core6option13expect_failed17hd9879ea489f48b8fE>
ffffffff80001b7d:	48 8d 3d ca 2c 00 00 	lea    rdi,[rip+0x2cca]        # ffffffff8000484e <memset+0x106e>
ffffffff80001b84:	48 8d 15 bd 09 01 00 	lea    rdx,[rip+0x109bd]        # ffffffff80012548 <memset+0xed68>
ffffffff80001b8b:	be 1f 00 00 00       	mov    esi,0x1f
ffffffff80001b90:	e8 4b 1b 00 00       	call   ffffffff800036e0 <_ZN4core6option13expect_failed17hd9879ea489f48b8fE>
ffffffff80001b95:	48 8d 3d dd 2c 00 00 	lea    rdi,[rip+0x2cdd]        # ffffffff80004879 <memset+0x1099>
ffffffff80001b9c:	48 8d 15 bd 09 01 00 	lea    rdx,[rip+0x109bd]        # ffffffff80012560 <memset+0xed80>
ffffffff80001ba3:	be 28 00 00 00       	mov    esi,0x28
ffffffff80001ba8:	e8 33 1b 00 00       	call   ffffffff800036e0 <_ZN4core6option13expect_failed17hd9879ea489f48b8fE>
ffffffff80001bad:	48 8d 3d ed 2c 00 00 	lea    rdi,[rip+0x2ced]        # ffffffff800048a1 <memset+0x10c1>
ffffffff80001bb4:	48 8d 15 bd 09 01 00 	lea    rdx,[rip+0x109bd]        # ffffffff80012578 <memset+0xed98>
ffffffff80001bbb:	be 36 00 00 00       	mov    esi,0x36
ffffffff80001bc0:	e8 1b 1b 00 00       	call   ffffffff800036e0 <_ZN4core6option13expect_failed17hd9879ea489f48b8fE>
ffffffff80001bc5:	48 8d 05 9c 0b 01 00 	lea    rax,[rip+0x10b9c]        # ffffffff80012768 <memset+0xef88>
ffffffff80001bcc:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001bd3:	00 
ffffffff80001bd4:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001bdb:	00 01 00 00 00 
ffffffff80001be0:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001be7:	00 00 00 00 00 
ffffffff80001bec:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001bf3:	00 08 00 00 00 
ffffffff80001bf8:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001bff:	00 00 00 00 00 
ffffffff80001c04:	48 8d 35 6d 0b 01 00 	lea    rsi,[rip+0x10b6d]        # ffffffff80012778 <memset+0xef98>
ffffffff80001c0b:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001c12:	00 
ffffffff80001c13:	e8 58 05 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001c18:	48 8d 05 21 0b 01 00 	lea    rax,[rip+0x10b21]        # ffffffff80012740 <memset+0xef60>
ffffffff80001c1f:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001c26:	00 
ffffffff80001c27:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001c2e:	00 01 00 00 00 
ffffffff80001c33:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001c3a:	00 00 00 00 00 
ffffffff80001c3f:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001c46:	00 08 00 00 00 
ffffffff80001c4b:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001c52:	00 00 00 00 00 
ffffffff80001c57:	48 8d 35 f2 0a 01 00 	lea    rsi,[rip+0x10af2]        # ffffffff80012750 <memset+0xef70>
ffffffff80001c5e:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001c65:	00 
ffffffff80001c66:	e8 05 05 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001c6b:	48 8d 05 a6 0a 01 00 	lea    rax,[rip+0x10aa6]        # ffffffff80012718 <memset+0xef38>
ffffffff80001c72:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001c79:	00 
ffffffff80001c7a:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001c81:	00 01 00 00 00 
ffffffff80001c86:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001c8d:	00 00 00 00 00 
ffffffff80001c92:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001c99:	00 08 00 00 00 
ffffffff80001c9e:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001ca5:	00 00 00 00 00 
ffffffff80001caa:	48 8d 35 77 0a 01 00 	lea    rsi,[rip+0x10a77]        # ffffffff80012728 <memset+0xef48>
ffffffff80001cb1:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001cb8:	00 
ffffffff80001cb9:	e8 b2 04 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001cbe:	48 8d 05 2b 0a 01 00 	lea    rax,[rip+0x10a2b]        # ffffffff800126f0 <memset+0xef10>
ffffffff80001cc5:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001ccc:	00 
ffffffff80001ccd:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001cd4:	00 01 00 00 00 
ffffffff80001cd9:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001ce0:	00 00 00 00 00 
ffffffff80001ce5:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001cec:	00 08 00 00 00 
ffffffff80001cf1:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001cf8:	00 00 00 00 00 
ffffffff80001cfd:	48 8d 35 fc 09 01 00 	lea    rsi,[rip+0x109fc]        # ffffffff80012700 <memset+0xef20>
ffffffff80001d04:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001d0b:	00 
ffffffff80001d0c:	e8 5f 04 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001d11:	48 8d 05 b0 09 01 00 	lea    rax,[rip+0x109b0]        # ffffffff800126c8 <memset+0xeee8>
ffffffff80001d18:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001d1f:	00 
ffffffff80001d20:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001d27:	00 01 00 00 00 
ffffffff80001d2c:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001d33:	00 00 00 00 00 
ffffffff80001d38:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001d3f:	00 08 00 00 00 
ffffffff80001d44:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001d4b:	00 00 00 00 00 
ffffffff80001d50:	48 8d 35 81 09 01 00 	lea    rsi,[rip+0x10981]        # ffffffff800126d8 <memset+0xeef8>
ffffffff80001d57:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001d5e:	00 
ffffffff80001d5f:	e8 0c 04 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001d64:	48 8d 05 35 09 01 00 	lea    rax,[rip+0x10935]        # ffffffff800126a0 <memset+0xeec0>
ffffffff80001d6b:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001d72:	00 
ffffffff80001d73:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001d7a:	00 01 00 00 00 
ffffffff80001d7f:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001d86:	00 00 00 00 00 
ffffffff80001d8b:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001d92:	00 08 00 00 00 
ffffffff80001d97:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001d9e:	00 00 00 00 00 
ffffffff80001da3:	48 8d 35 06 09 01 00 	lea    rsi,[rip+0x10906]        # ffffffff800126b0 <memset+0xeed0>
ffffffff80001daa:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001db1:	00 
ffffffff80001db2:	e8 b9 03 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001db7:	48 8d 05 ba 08 01 00 	lea    rax,[rip+0x108ba]        # ffffffff80012678 <memset+0xee98>
ffffffff80001dbe:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001dc5:	00 
ffffffff80001dc6:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001dcd:	00 01 00 00 00 
ffffffff80001dd2:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001dd9:	00 00 00 00 00 
ffffffff80001dde:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001de5:	00 08 00 00 00 
ffffffff80001dea:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001df1:	00 00 00 00 00 
ffffffff80001df6:	48 8d 35 8b 08 01 00 	lea    rsi,[rip+0x1088b]        # ffffffff80012688 <memset+0xeea8>
ffffffff80001dfd:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001e04:	00 
ffffffff80001e05:	e8 66 03 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001e0a:	48 8d 05 3f 08 01 00 	lea    rax,[rip+0x1083f]        # ffffffff80012650 <memset+0xee70>
ffffffff80001e11:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001e18:	00 
ffffffff80001e19:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001e20:	00 01 00 00 00 
ffffffff80001e25:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001e2c:	00 00 00 00 00 
ffffffff80001e31:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001e38:	00 08 00 00 00 
ffffffff80001e3d:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001e44:	00 00 00 00 00 
ffffffff80001e49:	48 8d 35 10 08 01 00 	lea    rsi,[rip+0x10810]        # ffffffff80012660 <memset+0xee80>
ffffffff80001e50:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001e57:	00 
ffffffff80001e58:	e8 13 03 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001e5d:	48 8d 05 c4 07 01 00 	lea    rax,[rip+0x107c4]        # ffffffff80012628 <memset+0xee48>
ffffffff80001e64:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001e6b:	00 
ffffffff80001e6c:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001e73:	00 01 00 00 00 
ffffffff80001e78:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001e7f:	00 00 00 00 00 
ffffffff80001e84:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001e8b:	00 08 00 00 00 
ffffffff80001e90:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001e97:	00 00 00 00 00 
ffffffff80001e9c:	48 8d 35 95 07 01 00 	lea    rsi,[rip+0x10795]        # ffffffff80012638 <memset+0xee58>
ffffffff80001ea3:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001eaa:	00 
ffffffff80001eab:	e8 c0 02 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001eb0:	48 8d 05 49 07 01 00 	lea    rax,[rip+0x10749]        # ffffffff80012600 <memset+0xee20>
ffffffff80001eb7:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001ebe:	00 
ffffffff80001ebf:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001ec6:	00 01 00 00 00 
ffffffff80001ecb:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001ed2:	00 00 00 00 00 
ffffffff80001ed7:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001ede:	00 08 00 00 00 
ffffffff80001ee3:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001eea:	00 00 00 00 00 
ffffffff80001eef:	48 8d 35 1a 07 01 00 	lea    rsi,[rip+0x1071a]        # ffffffff80012610 <memset+0xee30>
ffffffff80001ef6:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001efd:	00 
ffffffff80001efe:	e8 6d 02 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001f03:	48 8d 05 ce 06 01 00 	lea    rax,[rip+0x106ce]        # ffffffff800125d8 <memset+0xedf8>
ffffffff80001f0a:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001f11:	00 
ffffffff80001f12:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001f19:	00 01 00 00 00 
ffffffff80001f1e:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001f25:	00 00 00 00 00 
ffffffff80001f2a:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001f31:	00 08 00 00 00 
ffffffff80001f36:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001f3d:	00 00 00 00 00 
ffffffff80001f42:	48 8d 35 9f 06 01 00 	lea    rsi,[rip+0x1069f]        # ffffffff800125e8 <memset+0xee08>
ffffffff80001f49:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001f50:	00 
ffffffff80001f51:	e8 1a 02 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001f56:	48 8d 05 53 06 01 00 	lea    rax,[rip+0x10653]        # ffffffff800125b0 <memset+0xedd0>
ffffffff80001f5d:	48 89 84 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rax
ffffffff80001f64:	00 
ffffffff80001f65:	48 c7 84 24 88 00 00 	mov    QWORD PTR [rsp+0x88],0x1
ffffffff80001f6c:	00 01 00 00 00 
ffffffff80001f71:	48 c7 84 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],0x0
ffffffff80001f78:	00 00 00 00 00 
ffffffff80001f7d:	48 c7 84 24 90 00 00 	mov    QWORD PTR [rsp+0x90],0x8
ffffffff80001f84:	00 08 00 00 00 
ffffffff80001f89:	48 c7 84 24 98 00 00 	mov    QWORD PTR [rsp+0x98],0x0
ffffffff80001f90:	00 00 00 00 00 
ffffffff80001f95:	48 8d 35 24 06 01 00 	lea    rsi,[rip+0x10624]        # ffffffff800125c0 <memset+0xede0>
ffffffff80001f9c:	48 8d bc 24 80 00 00 	lea    rdi,[rsp+0x80]
ffffffff80001fa3:	00 
ffffffff80001fa4:	e8 c7 01 00 00       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80001fa9:	48 8d 3d 4a 43 00 00 	lea    rdi,[rip+0x434a]        # ffffffff800062fa <memset+0x2b1a>
ffffffff80001fb0:	48 8d 15 89 40 01 00 	lea    rdx,[rip+0x14089]        # ffffffff80016040 <memset+0x12860>
ffffffff80001fb7:	be 30 00 00 00       	mov    esi,0x30
ffffffff80001fbc:	e8 1f 17 00 00       	call   ffffffff800036e0 <_ZN4core6option13expect_failed17hd9879ea489f48b8fE>
ffffffff80001fc1:	cc                   	int3   
ffffffff80001fc2:	cc                   	int3   
ffffffff80001fc3:	cc                   	int3   
ffffffff80001fc4:	cc                   	int3   
ffffffff80001fc5:	cc                   	int3   
ffffffff80001fc6:	cc                   	int3   
ffffffff80001fc7:	cc                   	int3   
ffffffff80001fc8:	cc                   	int3   
ffffffff80001fc9:	cc                   	int3   
ffffffff80001fca:	cc                   	int3   
ffffffff80001fcb:	cc                   	int3   
ffffffff80001fcc:	cc                   	int3   
ffffffff80001fcd:	cc                   	int3   
ffffffff80001fce:	cc                   	int3   
ffffffff80001fcf:	cc                   	int3   

ffffffff80001fd0 <rust_begin_unwind>:
ffffffff80001fd0:	41 57                	push   r15
ffffffff80001fd2:	41 56                	push   r14
ffffffff80001fd4:	41 55                	push   r13
ffffffff80001fd6:	41 54                	push   r12
ffffffff80001fd8:	53                   	push   rbx
ffffffff80001fd9:	48 81 ec 80 00 00 00 	sub    rsp,0x80
ffffffff80001fe0:	49 89 ff             	mov    r15,rdi
ffffffff80001fe3:	48 8d 05 76 41 01 00 	lea    rax,[rip+0x14176]        # ffffffff80016160 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x80>
ffffffff80001fea:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff80001fef:	48 c7 44 24 18 01 00 	mov    QWORD PTR [rsp+0x18],0x1
ffffffff80001ff6:	00 00 
ffffffff80001ff8:	48 c7 44 24 30 00 00 	mov    QWORD PTR [rsp+0x30],0x0
ffffffff80001fff:	00 00 
ffffffff80002001:	48 8d 5c 24 08       	lea    rbx,[rsp+0x8]
ffffffff80002006:	48 89 5c 24 20       	mov    QWORD PTR [rsp+0x20],rbx
ffffffff8000200b:	48 c7 44 24 28 00 00 	mov    QWORD PTR [rsp+0x28],0x0
ffffffff80002012:	00 00 
ffffffff80002014:	4c 8d 35 7d 04 01 00 	lea    r14,[rip+0x1047d]        # ffffffff80012498 <memset+0xecb8>
ffffffff8000201b:	48 8d 54 24 10       	lea    rdx,[rsp+0x10]
ffffffff80002020:	48 89 df             	mov    rdi,rbx
ffffffff80002023:	4c 89 f6             	mov    rsi,r14
ffffffff80002026:	e8 85 0e 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff8000202b:	48 8d 05 3e 41 01 00 	lea    rax,[rip+0x1413e]        # ffffffff80016170 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x90>
ffffffff80002032:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff80002037:	48 c7 44 24 18 01 00 	mov    QWORD PTR [rsp+0x18],0x1
ffffffff8000203e:	00 00 
ffffffff80002040:	48 c7 44 24 30 00 00 	mov    QWORD PTR [rsp+0x30],0x0
ffffffff80002047:	00 00 
ffffffff80002049:	48 c7 44 24 20 08 00 	mov    QWORD PTR [rsp+0x20],0x8
ffffffff80002050:	00 00 
ffffffff80002052:	48 c7 44 24 28 00 00 	mov    QWORD PTR [rsp+0x28],0x0
ffffffff80002059:	00 00 
ffffffff8000205b:	48 8d 54 24 10       	lea    rdx,[rsp+0x10]
ffffffff80002060:	48 89 df             	mov    rdi,rbx
ffffffff80002063:	4c 89 f6             	mov    rsi,r14
ffffffff80002066:	e8 45 0e 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff8000206b:	49 8b 47 30          	mov    rax,QWORD PTR [r15+0x30]
ffffffff8000206f:	48 89 44 24 40       	mov    QWORD PTR [rsp+0x40],rax
ffffffff80002074:	4c 8d 6c 24 40       	lea    r13,[rsp+0x40]
ffffffff80002079:	4c 89 6c 24 50       	mov    QWORD PTR [rsp+0x50],r13
ffffffff8000207e:	48 8d 05 7b e1 ff ff 	lea    rax,[rip+0xffffffffffffe17b]        # ffffffff80000200 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf9e1b85a2cf7a76dE>
ffffffff80002085:	48 89 44 24 58       	mov    QWORD PTR [rsp+0x58],rax
ffffffff8000208a:	48 8d 05 97 04 01 00 	lea    rax,[rip+0x10497]        # ffffffff80012528 <memset+0xed48>
ffffffff80002091:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff80002096:	48 c7 44 24 18 02 00 	mov    QWORD PTR [rsp+0x18],0x2
ffffffff8000209d:	00 00 
ffffffff8000209f:	48 c7 44 24 30 00 00 	mov    QWORD PTR [rsp+0x30],0x0
ffffffff800020a6:	00 00 
ffffffff800020a8:	48 8d 44 24 50       	lea    rax,[rsp+0x50]
ffffffff800020ad:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff800020b2:	48 c7 44 24 28 01 00 	mov    QWORD PTR [rsp+0x28],0x1
ffffffff800020b9:	00 00 
ffffffff800020bb:	4c 8d 64 24 10       	lea    r12,[rsp+0x10]
ffffffff800020c0:	48 89 df             	mov    rdi,rbx
ffffffff800020c3:	4c 89 f6             	mov    rsi,r14
ffffffff800020c6:	4c 89 e2             	mov    rdx,r12
ffffffff800020c9:	e8 e2 0d 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff800020ce:	49 8b 47 28          	mov    rax,QWORD PTR [r15+0x28]
ffffffff800020d2:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
ffffffff800020d7:	49 8b 47 20          	mov    rax,QWORD PTR [r15+0x20]
ffffffff800020db:	48 89 44 24 30       	mov    QWORD PTR [rsp+0x30],rax
ffffffff800020e0:	49 8b 47 18          	mov    rax,QWORD PTR [r15+0x18]
ffffffff800020e4:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
ffffffff800020e9:	49 8b 47 10          	mov    rax,QWORD PTR [r15+0x10]
ffffffff800020ed:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff800020f2:	49 8b 07             	mov    rax,QWORD PTR [r15]
ffffffff800020f5:	49 8b 4f 08          	mov    rcx,QWORD PTR [r15+0x8]
ffffffff800020f9:	48 89 4c 24 18       	mov    QWORD PTR [rsp+0x18],rcx
ffffffff800020fe:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff80002103:	4c 89 64 24 40       	mov    QWORD PTR [rsp+0x40],r12
ffffffff80002108:	48 8d 05 21 e4 ff ff 	lea    rax,[rip+0xffffffffffffe421]        # ffffffff80000530 <_ZN76_$LT$core..panic..panic_info..PanicMessage$u20$as$u20$core..fmt..Display$GT$3fmt17h030ce0cb2da8e6e2E>
ffffffff8000210f:	48 89 44 24 48       	mov    QWORD PTR [rsp+0x48],rax
ffffffff80002114:	48 8d 05 65 40 01 00 	lea    rax,[rip+0x14065]        # ffffffff80016180 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0xa0>
ffffffff8000211b:	48 89 44 24 50       	mov    QWORD PTR [rsp+0x50],rax
ffffffff80002120:	48 c7 44 24 58 01 00 	mov    QWORD PTR [rsp+0x58],0x1
ffffffff80002127:	00 00 
ffffffff80002129:	48 c7 44 24 70 00 00 	mov    QWORD PTR [rsp+0x70],0x0
ffffffff80002130:	00 00 
ffffffff80002132:	4c 89 6c 24 60       	mov    QWORD PTR [rsp+0x60],r13
ffffffff80002137:	48 c7 44 24 68 01 00 	mov    QWORD PTR [rsp+0x68],0x1
ffffffff8000213e:	00 00 
ffffffff80002140:	48 8d 54 24 50       	lea    rdx,[rsp+0x50]
ffffffff80002145:	48 89 df             	mov    rdi,rbx
ffffffff80002148:	4c 89 f6             	mov    rsi,r14
ffffffff8000214b:	e8 60 0d 00 00       	call   ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff80002150:	fa                   	cli    
ffffffff80002151:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80002158:	0f 1f 84 00 00 00 00 
ffffffff8000215f:	00 
ffffffff80002160:	f4                   	hlt    
ffffffff80002161:	eb fd                	jmp    ffffffff80002160 <rust_begin_unwind+0x190>
ffffffff80002163:	cc                   	int3   
ffffffff80002164:	cc                   	int3   
ffffffff80002165:	cc                   	int3   
ffffffff80002166:	cc                   	int3   
ffffffff80002167:	cc                   	int3   
ffffffff80002168:	cc                   	int3   
ffffffff80002169:	cc                   	int3   
ffffffff8000216a:	cc                   	int3   
ffffffff8000216b:	cc                   	int3   
ffffffff8000216c:	cc                   	int3   
ffffffff8000216d:	cc                   	int3   
ffffffff8000216e:	cc                   	int3   
ffffffff8000216f:	cc                   	int3   

ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>:
ffffffff80002170:	48 83 ec 48          	sub    rsp,0x48
ffffffff80002174:	48 8b 47 28          	mov    rax,QWORD PTR [rdi+0x28]
ffffffff80002178:	48 89 44 24 30       	mov    QWORD PTR [rsp+0x30],rax
ffffffff8000217d:	48 8b 47 20          	mov    rax,QWORD PTR [rdi+0x20]
ffffffff80002181:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
ffffffff80002186:	48 8b 47 18          	mov    rax,QWORD PTR [rdi+0x18]
ffffffff8000218a:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff8000218f:	48 8b 47 10          	mov    rax,QWORD PTR [rdi+0x10]
ffffffff80002193:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff80002198:	48 8b 07             	mov    rax,QWORD PTR [rdi]
ffffffff8000219b:	48 8b 4f 08          	mov    rcx,QWORD PTR [rdi+0x8]
ffffffff8000219f:	48 89 4c 24 10       	mov    QWORD PTR [rsp+0x10],rcx
ffffffff800021a4:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
ffffffff800021a9:	48 89 74 24 38       	mov    QWORD PTR [rsp+0x38],rsi
ffffffff800021ae:	66 c7 44 24 40 01 00 	mov    WORD PTR [rsp+0x40],0x1
ffffffff800021b5:	48 8d 7c 24 08       	lea    rdi,[rsp+0x8]
ffffffff800021ba:	e8 11 fe ff ff       	call   ffffffff80001fd0 <rust_begin_unwind>
ffffffff800021bf:	cc                   	int3   

ffffffff800021c0 <_ZN4core5slice5index26slice_start_index_len_fail17he0c8b7fd2d8ebd25E>:
ffffffff800021c0:	48 83 ec 68          	sub    rsp,0x68
ffffffff800021c4:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
ffffffff800021c9:	48 c7 44 24 10 80 00 	mov    QWORD PTR [rsp+0x10],0x80
ffffffff800021d0:	00 00 
ffffffff800021d2:	48 8d 44 24 08       	lea    rax,[rsp+0x8]
ffffffff800021d7:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff800021dc:	48 8d 05 dd 00 00 00 	lea    rax,[rip+0xdd]        # ffffffff800022c0 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E>
ffffffff800021e3:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff800021e8:	48 8d 4c 24 10       	lea    rcx,[rsp+0x10]
ffffffff800021ed:	48 89 4c 24 28       	mov    QWORD PTR [rsp+0x28],rcx
ffffffff800021f2:	48 89 44 24 30       	mov    QWORD PTR [rsp+0x30],rax
ffffffff800021f7:	48 8d 05 2a 40 01 00 	lea    rax,[rip+0x1402a]        # ffffffff80016228 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x148>
ffffffff800021fe:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
ffffffff80002203:	48 c7 44 24 40 02 00 	mov    QWORD PTR [rsp+0x40],0x2
ffffffff8000220a:	00 00 
ffffffff8000220c:	48 c7 44 24 58 00 00 	mov    QWORD PTR [rsp+0x58],0x0
ffffffff80002213:	00 00 
ffffffff80002215:	48 8d 44 24 18       	lea    rax,[rsp+0x18]
ffffffff8000221a:	48 89 44 24 48       	mov    QWORD PTR [rsp+0x48],rax
ffffffff8000221f:	48 c7 44 24 50 02 00 	mov    QWORD PTR [rsp+0x50],0x2
ffffffff80002226:	00 00 
ffffffff80002228:	48 8d 35 e1 3f 01 00 	lea    rsi,[rip+0x13fe1]        # ffffffff80016210 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x130>
ffffffff8000222f:	48 8d 7c 24 38       	lea    rdi,[rsp+0x38]
ffffffff80002234:	e8 37 ff ff ff       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80002239:	cc                   	int3   
ffffffff8000223a:	cc                   	int3   
ffffffff8000223b:	cc                   	int3   
ffffffff8000223c:	cc                   	int3   
ffffffff8000223d:	cc                   	int3   
ffffffff8000223e:	cc                   	int3   
ffffffff8000223f:	cc                   	int3   

ffffffff80002240 <_ZN4core9panicking18panic_bounds_check17h4a57ffaa181cea47E>:
ffffffff80002240:	48 83 ec 68          	sub    rsp,0x68
ffffffff80002244:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
ffffffff80002249:	48 c7 44 24 10 80 00 	mov    QWORD PTR [rsp+0x10],0x80
ffffffff80002250:	00 00 
ffffffff80002252:	48 8d 44 24 10       	lea    rax,[rsp+0x10]
ffffffff80002257:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff8000225c:	48 8d 05 5d 00 00 00 	lea    rax,[rip+0x5d]        # ffffffff800022c0 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E>
ffffffff80002263:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff80002268:	48 8d 4c 24 08       	lea    rcx,[rsp+0x8]
ffffffff8000226d:	48 89 4c 24 28       	mov    QWORD PTR [rsp+0x28],rcx
ffffffff80002272:	48 89 44 24 30       	mov    QWORD PTR [rsp+0x30],rax
ffffffff80002277:	48 8d 05 42 3f 01 00 	lea    rax,[rip+0x13f42]        # ffffffff800161c0 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0xe0>
ffffffff8000227e:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
ffffffff80002283:	48 c7 44 24 40 02 00 	mov    QWORD PTR [rsp+0x40],0x2
ffffffff8000228a:	00 00 
ffffffff8000228c:	48 c7 44 24 58 00 00 	mov    QWORD PTR [rsp+0x58],0x0
ffffffff80002293:	00 00 
ffffffff80002295:	48 8d 44 24 18       	lea    rax,[rsp+0x18]
ffffffff8000229a:	48 89 44 24 48       	mov    QWORD PTR [rsp+0x48],rax
ffffffff8000229f:	48 c7 44 24 50 02 00 	mov    QWORD PTR [rsp+0x50],0x2
ffffffff800022a6:	00 00 
ffffffff800022a8:	48 8d 7c 24 38       	lea    rdi,[rsp+0x38]
ffffffff800022ad:	e8 be fe ff ff       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff800022b2:	cc                   	int3   
ffffffff800022b3:	cc                   	int3   
ffffffff800022b4:	cc                   	int3   
ffffffff800022b5:	cc                   	int3   
ffffffff800022b6:	cc                   	int3   
ffffffff800022b7:	cc                   	int3   
ffffffff800022b8:	cc                   	int3   
ffffffff800022b9:	cc                   	int3   
ffffffff800022ba:	cc                   	int3   
ffffffff800022bb:	cc                   	int3   
ffffffff800022bc:	cc                   	int3   
ffffffff800022bd:	cc                   	int3   
ffffffff800022be:	cc                   	int3   
ffffffff800022bf:	cc                   	int3   

ffffffff800022c0 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E>:
ffffffff800022c0:	48 83 ec 28          	sub    rsp,0x28
ffffffff800022c4:	48 89 f0             	mov    rax,rsi
ffffffff800022c7:	48 8b 17             	mov    rdx,QWORD PTR [rdi]
ffffffff800022ca:	be 27 00 00 00       	mov    esi,0x27
ffffffff800022cf:	48 8d 0d a4 41 00 00 	lea    rcx,[rip+0x41a4]        # ffffffff8000647a <memset+0x2c9a>
ffffffff800022d6:	48 81 fa 10 27 00 00 	cmp    rdx,0x2710
ffffffff800022dd:	0f 82 b3 00 00 00    	jb     ffffffff80002396 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E+0xd6>
ffffffff800022e3:	41 b9 27 00 00 00    	mov    r9d,0x27
ffffffff800022e9:	49 b8 4b 59 86 38 d6 	movabs r8,0x346dc5d63886594b
ffffffff800022f0:	c5 6d 34 
ffffffff800022f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff800022fa:	84 00 00 00 00 00 
ffffffff80002300:	c4 c2 c3 f6 f8       	mulx   rdi,rdi,r8
ffffffff80002305:	48 c1 ef 0b          	shr    rdi,0xb
ffffffff80002309:	69 f7 10 27 00 00    	imul   esi,edi,0x2710
ffffffff8000230f:	41 89 d2             	mov    r10d,edx
ffffffff80002312:	41 29 f2             	sub    r10d,esi
ffffffff80002315:	45 69 da 7b 14 00 00 	imul   r11d,r10d,0x147b
ffffffff8000231c:	41 c1 eb 13          	shr    r11d,0x13
ffffffff80002320:	41 6b f3 64          	imul   esi,r11d,0x64
ffffffff80002324:	41 29 f2             	sub    r10d,esi
ffffffff80002327:	45 0f b7 d2          	movzx  r10d,r10w
ffffffff8000232b:	49 8d 71 fc          	lea    rsi,[r9-0x4]
ffffffff8000232f:	46 0f b7 1c 59       	movzx  r11d,WORD PTR [rcx+r11*2]
ffffffff80002334:	66 46 89 5c 0c fd    	mov    WORD PTR [rsp+r9*1-0x3],r11w
ffffffff8000233a:	46 0f b7 14 51       	movzx  r10d,WORD PTR [rcx+r10*2]
ffffffff8000233f:	66 46 89 54 0c ff    	mov    WORD PTR [rsp+r9*1-0x1],r10w
ffffffff80002345:	49 89 f1             	mov    r9,rsi
ffffffff80002348:	48 81 fa ff e0 f5 05 	cmp    rdx,0x5f5e0ff
ffffffff8000234f:	48 89 fa             	mov    rdx,rdi
ffffffff80002352:	77 ac                	ja     ffffffff80002300 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E+0x40>
ffffffff80002354:	48 83 ff 63          	cmp    rdi,0x63
ffffffff80002358:	76 29                	jbe    ffffffff80002383 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E+0xc3>
ffffffff8000235a:	0f b7 d7             	movzx  edx,di
ffffffff8000235d:	c1 ea 02             	shr    edx,0x2
ffffffff80002360:	69 d2 7b 14 00 00    	imul   edx,edx,0x147b
ffffffff80002366:	c1 ea 11             	shr    edx,0x11
ffffffff80002369:	44 6b c2 64          	imul   r8d,edx,0x64
ffffffff8000236d:	44 29 c7             	sub    edi,r8d
ffffffff80002370:	0f b7 ff             	movzx  edi,di
ffffffff80002373:	0f b7 3c 79          	movzx  edi,WORD PTR [rcx+rdi*2]
ffffffff80002377:	66 89 7c 34 ff       	mov    WORD PTR [rsp+rsi*1-0x1],di
ffffffff8000237c:	48 83 c6 fe          	add    rsi,0xfffffffffffffffe
ffffffff80002380:	48 89 d7             	mov    rdi,rdx
ffffffff80002383:	48 83 ff 0a          	cmp    rdi,0xa
ffffffff80002387:	73 18                	jae    ffffffff800023a1 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E+0xe1>
ffffffff80002389:	40 80 cf 30          	or     dil,0x30
ffffffff8000238d:	40 88 3c 34          	mov    BYTE PTR [rsp+rsi*1],dil
ffffffff80002391:	48 ff ce             	dec    rsi
ffffffff80002394:	eb 18                	jmp    ffffffff800023ae <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E+0xee>
ffffffff80002396:	48 89 d7             	mov    rdi,rdx
ffffffff80002399:	48 83 ff 63          	cmp    rdi,0x63
ffffffff8000239d:	77 bb                	ja     ffffffff8000235a <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E+0x9a>
ffffffff8000239f:	eb e2                	jmp    ffffffff80002383 <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hd0525059669e8d61E+0xc3>
ffffffff800023a1:	0f b7 0c 79          	movzx  ecx,WORD PTR [rcx+rdi*2]
ffffffff800023a5:	66 89 4c 34 ff       	mov    WORD PTR [rsp+rsi*1-0x1],cx
ffffffff800023aa:	48 83 c6 fe          	add    rsi,0xfffffffffffffffe
ffffffff800023ae:	48 8d 0c 34          	lea    rcx,[rsp+rsi*1]
ffffffff800023b2:	48 ff c1             	inc    rcx
ffffffff800023b5:	41 b8 27 00 00 00    	mov    r8d,0x27
ffffffff800023bb:	49 29 f0             	sub    r8,rsi
ffffffff800023be:	be 01 00 00 00       	mov    esi,0x1
ffffffff800023c3:	48 89 c7             	mov    rdi,rax
ffffffff800023c6:	31 d2                	xor    edx,edx
ffffffff800023c8:	e8 13 00 00 00       	call   ffffffff800023e0 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E>
ffffffff800023cd:	48 83 c4 28          	add    rsp,0x28
ffffffff800023d1:	c3                   	ret    
ffffffff800023d2:	cc                   	int3   
ffffffff800023d3:	cc                   	int3   
ffffffff800023d4:	cc                   	int3   
ffffffff800023d5:	cc                   	int3   
ffffffff800023d6:	cc                   	int3   
ffffffff800023d7:	cc                   	int3   
ffffffff800023d8:	cc                   	int3   
ffffffff800023d9:	cc                   	int3   
ffffffff800023da:	cc                   	int3   
ffffffff800023db:	cc                   	int3   
ffffffff800023dc:	cc                   	int3   
ffffffff800023dd:	cc                   	int3   
ffffffff800023de:	cc                   	int3   
ffffffff800023df:	cc                   	int3   

ffffffff800023e0 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E>:
ffffffff800023e0:	55                   	push   rbp
ffffffff800023e1:	41 57                	push   r15
ffffffff800023e3:	41 56                	push   r14
ffffffff800023e5:	41 55                	push   r13
ffffffff800023e7:	41 54                	push   r12
ffffffff800023e9:	53                   	push   rbx
ffffffff800023ea:	48 83 ec 38          	sub    rsp,0x38
ffffffff800023ee:	4d 89 c5             	mov    r13,r8
ffffffff800023f1:	49 89 cf             	mov    r15,rcx
ffffffff800023f4:	49 89 f4             	mov    r12,rsi
ffffffff800023f7:	8b 47 34             	mov    eax,DWORD PTR [rdi+0x34]
ffffffff800023fa:	89 c1                	mov    ecx,eax
ffffffff800023fc:	83 e1 01             	and    ecx,0x1
ffffffff800023ff:	be 00 00 11 00       	mov    esi,0x110000
ffffffff80002404:	bd 2b 00 00 00       	mov    ebp,0x2b
ffffffff80002409:	0f 44 ee             	cmove  ebp,esi
ffffffff8000240c:	4c 01 c1             	add    rcx,r8
ffffffff8000240f:	a8 04                	test   al,0x4
ffffffff80002411:	75 4d                	jne    ffffffff80002460 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x80>
ffffffff80002413:	45 31 e4             	xor    r12d,r12d
ffffffff80002416:	48 83 3f 00          	cmp    QWORD PTR [rdi],0x0
ffffffff8000241a:	0f 84 e4 01 00 00    	je     ffffffff80002604 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x224>
ffffffff80002420:	4c 89 7c 24 18       	mov    QWORD PTR [rsp+0x18],r15
ffffffff80002425:	4c 8b 7f 08          	mov    r15,QWORD PTR [rdi+0x8]
ffffffff80002429:	49 29 cf             	sub    r15,rcx
ffffffff8000242c:	76 50                	jbe    ffffffff8000247e <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x9e>
ffffffff8000242e:	a8 08                	test   al,0x8
ffffffff80002430:	0f 85 87 00 00 00    	jne    ffffffff800024bd <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0xdd>
ffffffff80002436:	0f b6 47 38          	movzx  eax,BYTE PTR [rdi+0x38]
ffffffff8000243a:	48 8d 0d a7 23 00 00 	lea    rcx,[rip+0x23a7]        # ffffffff800047e8 <memset+0x1008>
ffffffff80002441:	48 63 34 81          	movsxd rsi,DWORD PTR [rcx+rax*4]
ffffffff80002445:	48 01 ce             	add    rsi,rcx
ffffffff80002448:	4c 89 6c 24 28       	mov    QWORD PTR [rsp+0x28],r13
ffffffff8000244d:	48 89 54 24 30       	mov    QWORD PTR [rsp+0x30],rdx
ffffffff80002452:	ff e6                	jmp    rsi
ffffffff80002454:	31 c0                	xor    eax,eax
ffffffff80002456:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff8000245b:	e9 2e 02 00 00       	jmp    ffffffff8000268e <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x2ae>
ffffffff80002460:	48 85 d2             	test   rdx,rdx
ffffffff80002463:	74 50                	je     ffffffff800024b5 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0xd5>
ffffffff80002465:	89 d3                	mov    ebx,edx
ffffffff80002467:	83 e3 07             	and    ebx,0x7
ffffffff8000246a:	48 83 fa 08          	cmp    rdx,0x8
ffffffff8000246e:	0f 83 b9 00 00 00    	jae    ffffffff8000252d <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x14d>
ffffffff80002474:	45 31 c9             	xor    r9d,r9d
ffffffff80002477:	31 f6                	xor    esi,esi
ffffffff80002479:	e9 4e 01 00 00       	jmp    ffffffff800025cc <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x1ec>
ffffffff8000247e:	49 89 d0             	mov    r8,rdx
ffffffff80002481:	48 8b 5f 20          	mov    rbx,QWORD PTR [rdi+0x20]
ffffffff80002485:	4c 8b 77 28          	mov    r14,QWORD PTR [rdi+0x28]
ffffffff80002489:	48 89 df             	mov    rdi,rbx
ffffffff8000248c:	4c 89 f6             	mov    rsi,r14
ffffffff8000248f:	89 ea                	mov    edx,ebp
ffffffff80002491:	4c 89 e1             	mov    rcx,r12
ffffffff80002494:	e8 a7 02 00 00       	call   ffffffff80002740 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h378dc09f10704491E>
ffffffff80002499:	40 b5 01             	mov    bpl,0x1
ffffffff8000249c:	84 c0                	test   al,al
ffffffff8000249e:	48 8b 74 24 18       	mov    rsi,QWORD PTR [rsp+0x18]
ffffffff800024a3:	0f 85 7d 02 00 00    	jne    ffffffff80002726 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x346>
ffffffff800024a9:	49 8b 46 18          	mov    rax,QWORD PTR [r14+0x18]
ffffffff800024ad:	48 89 df             	mov    rdi,rbx
ffffffff800024b0:	e9 7f 01 00 00       	jmp    ffffffff80002634 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x254>
ffffffff800024b5:	45 31 c9             	xor    r9d,r9d
ffffffff800024b8:	e9 3a 01 00 00       	jmp    ffffffff800025f7 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x217>
ffffffff800024bd:	8b 47 30             	mov    eax,DWORD PTR [rdi+0x30]
ffffffff800024c0:	89 44 24 24          	mov    DWORD PTR [rsp+0x24],eax
ffffffff800024c4:	c7 47 30 30 00 00 00 	mov    DWORD PTR [rdi+0x30],0x30
ffffffff800024cb:	0f b6 47 38          	movzx  eax,BYTE PTR [rdi+0x38]
ffffffff800024cf:	88 44 24 0f          	mov    BYTE PTR [rsp+0xf],al
ffffffff800024d3:	c6 47 38 01          	mov    BYTE PTR [rdi+0x38],0x1
ffffffff800024d7:	4c 8b 77 20          	mov    r14,QWORD PTR [rdi+0x20]
ffffffff800024db:	48 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],rdi
ffffffff800024e0:	49 89 d0             	mov    r8,rdx
ffffffff800024e3:	48 8b 5f 28          	mov    rbx,QWORD PTR [rdi+0x28]
ffffffff800024e7:	4c 89 f7             	mov    rdi,r14
ffffffff800024ea:	48 89 de             	mov    rsi,rbx
ffffffff800024ed:	89 ea                	mov    edx,ebp
ffffffff800024ef:	4c 89 e1             	mov    rcx,r12
ffffffff800024f2:	e8 49 02 00 00       	call   ffffffff80002740 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h378dc09f10704491E>
ffffffff800024f7:	40 b5 01             	mov    bpl,0x1
ffffffff800024fa:	84 c0                	test   al,al
ffffffff800024fc:	0f 85 24 02 00 00    	jne    ffffffff80002726 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x346>
ffffffff80002502:	49 ff c7             	inc    r15
ffffffff80002505:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff8000250c:	00 00 00 00 
ffffffff80002510:	49 ff cf             	dec    r15
ffffffff80002513:	0f 84 2e 01 00 00    	je     ffffffff80002647 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x267>
ffffffff80002519:	4c 89 f7             	mov    rdi,r14
ffffffff8000251c:	be 30 00 00 00       	mov    esi,0x30
ffffffff80002521:	ff 53 20             	call   QWORD PTR [rbx+0x20]
ffffffff80002524:	84 c0                	test   al,al
ffffffff80002526:	74 e8                	je     ffffffff80002510 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x130>
ffffffff80002528:	e9 f9 01 00 00       	jmp    ffffffff80002726 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x346>
ffffffff8000252d:	49 89 d0             	mov    r8,rdx
ffffffff80002530:	49 83 e0 f8          	and    r8,0xfffffffffffffff8
ffffffff80002534:	45 31 c9             	xor    r9d,r9d
ffffffff80002537:	31 f6                	xor    esi,esi
ffffffff80002539:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
ffffffff80002540:	45 31 d2             	xor    r10d,r10d
ffffffff80002543:	41 80 3c 34 c0       	cmp    BYTE PTR [r12+rsi*1],0xc0
ffffffff80002548:	41 0f 9d c2          	setge  r10b
ffffffff8000254c:	4d 01 ca             	add    r10,r9
ffffffff8000254f:	45 31 db             	xor    r11d,r11d
ffffffff80002552:	41 80 7c 34 01 c0    	cmp    BYTE PTR [r12+rsi*1+0x1],0xc0
ffffffff80002558:	41 0f 9d c3          	setge  r11b
ffffffff8000255c:	45 31 c9             	xor    r9d,r9d
ffffffff8000255f:	41 80 7c 34 02 c0    	cmp    BYTE PTR [r12+rsi*1+0x2],0xc0
ffffffff80002565:	41 0f 9d c1          	setge  r9b
ffffffff80002569:	4d 01 d9             	add    r9,r11
ffffffff8000256c:	4d 01 d1             	add    r9,r10
ffffffff8000256f:	45 31 d2             	xor    r10d,r10d
ffffffff80002572:	41 80 7c 34 03 c0    	cmp    BYTE PTR [r12+rsi*1+0x3],0xc0
ffffffff80002578:	41 0f 9d c2          	setge  r10b
ffffffff8000257c:	45 31 db             	xor    r11d,r11d
ffffffff8000257f:	41 80 7c 34 04 c0    	cmp    BYTE PTR [r12+rsi*1+0x4],0xc0
ffffffff80002585:	41 0f 9d c3          	setge  r11b
ffffffff80002589:	4d 01 d3             	add    r11,r10
ffffffff8000258c:	45 31 d2             	xor    r10d,r10d
ffffffff8000258f:	41 80 7c 34 05 c0    	cmp    BYTE PTR [r12+rsi*1+0x5],0xc0
ffffffff80002595:	41 0f 9d c2          	setge  r10b
ffffffff80002599:	4d 01 da             	add    r10,r11
ffffffff8000259c:	4d 01 ca             	add    r10,r9
ffffffff8000259f:	45 31 db             	xor    r11d,r11d
ffffffff800025a2:	41 80 7c 34 06 c0    	cmp    BYTE PTR [r12+rsi*1+0x6],0xc0
ffffffff800025a8:	41 0f 9d c3          	setge  r11b
ffffffff800025ac:	45 31 c9             	xor    r9d,r9d
ffffffff800025af:	41 80 7c 34 07 c0    	cmp    BYTE PTR [r12+rsi*1+0x7],0xc0
ffffffff800025b5:	41 0f 9d c1          	setge  r9b
ffffffff800025b9:	4d 01 d9             	add    r9,r11
ffffffff800025bc:	4d 01 d1             	add    r9,r10
ffffffff800025bf:	48 83 c6 08          	add    rsi,0x8
ffffffff800025c3:	49 39 f0             	cmp    r8,rsi
ffffffff800025c6:	0f 85 74 ff ff ff    	jne    ffffffff80002540 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x160>
ffffffff800025cc:	48 85 db             	test   rbx,rbx
ffffffff800025cf:	74 26                	je     ffffffff800025f7 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x217>
ffffffff800025d1:	4c 01 e6             	add    rsi,r12
ffffffff800025d4:	45 31 c0             	xor    r8d,r8d
ffffffff800025d7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
ffffffff800025de:	00 00 
ffffffff800025e0:	45 31 d2             	xor    r10d,r10d
ffffffff800025e3:	42 80 3c 06 c0       	cmp    BYTE PTR [rsi+r8*1],0xc0
ffffffff800025e8:	41 0f 9d c2          	setge  r10b
ffffffff800025ec:	4d 01 d1             	add    r9,r10
ffffffff800025ef:	49 ff c0             	inc    r8
ffffffff800025f2:	4c 39 c3             	cmp    rbx,r8
ffffffff800025f5:	75 e9                	jne    ffffffff800025e0 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x200>
ffffffff800025f7:	4c 01 c9             	add    rcx,r9
ffffffff800025fa:	48 83 3f 00          	cmp    QWORD PTR [rdi],0x0
ffffffff800025fe:	0f 85 1c fe ff ff    	jne    ffffffff80002420 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x40>
ffffffff80002604:	49 89 d0             	mov    r8,rdx
ffffffff80002607:	48 8b 5f 20          	mov    rbx,QWORD PTR [rdi+0x20]
ffffffff8000260b:	4c 8b 77 28          	mov    r14,QWORD PTR [rdi+0x28]
ffffffff8000260f:	48 89 df             	mov    rdi,rbx
ffffffff80002612:	4c 89 f6             	mov    rsi,r14
ffffffff80002615:	89 ea                	mov    edx,ebp
ffffffff80002617:	4c 89 e1             	mov    rcx,r12
ffffffff8000261a:	e8 21 01 00 00       	call   ffffffff80002740 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h378dc09f10704491E>
ffffffff8000261f:	40 b5 01             	mov    bpl,0x1
ffffffff80002622:	84 c0                	test   al,al
ffffffff80002624:	0f 85 fc 00 00 00    	jne    ffffffff80002726 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x346>
ffffffff8000262a:	49 8b 46 18          	mov    rax,QWORD PTR [r14+0x18]
ffffffff8000262e:	48 89 df             	mov    rdi,rbx
ffffffff80002631:	4c 89 fe             	mov    rsi,r15
ffffffff80002634:	4c 89 ea             	mov    rdx,r13
ffffffff80002637:	48 83 c4 38          	add    rsp,0x38
ffffffff8000263b:	5b                   	pop    rbx
ffffffff8000263c:	41 5c                	pop    r12
ffffffff8000263e:	41 5d                	pop    r13
ffffffff80002640:	41 5e                	pop    r14
ffffffff80002642:	41 5f                	pop    r15
ffffffff80002644:	5d                   	pop    rbp
ffffffff80002645:	ff e0                	jmp    rax
ffffffff80002647:	4c 89 f7             	mov    rdi,r14
ffffffff8000264a:	48 8b 74 24 18       	mov    rsi,QWORD PTR [rsp+0x18]
ffffffff8000264f:	4c 89 ea             	mov    rdx,r13
ffffffff80002652:	ff 53 18             	call   QWORD PTR [rbx+0x18]
ffffffff80002655:	84 c0                	test   al,al
ffffffff80002657:	0f 85 c9 00 00 00    	jne    ffffffff80002726 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x346>
ffffffff8000265d:	4c 8b 6c 24 10       	mov    r13,QWORD PTR [rsp+0x10]
ffffffff80002662:	8b 44 24 24          	mov    eax,DWORD PTR [rsp+0x24]
ffffffff80002666:	41 89 45 30          	mov    DWORD PTR [r13+0x30],eax
ffffffff8000266a:	0f b6 44 24 0f       	movzx  eax,BYTE PTR [rsp+0xf]
ffffffff8000266f:	41 88 45 38          	mov    BYTE PTR [r13+0x38],al
ffffffff80002673:	31 ed                	xor    ebp,ebp
ffffffff80002675:	e9 ac 00 00 00       	jmp    ffffffff80002726 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x346>
ffffffff8000267a:	4c 89 f8             	mov    rax,r15
ffffffff8000267d:	48 d1 e8             	shr    rax,1
ffffffff80002680:	49 ff c7             	inc    r15
ffffffff80002683:	49 d1 ef             	shr    r15,1
ffffffff80002686:	4c 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],r15
ffffffff8000268b:	49 89 c7             	mov    r15,rax
ffffffff8000268e:	4c 8b 6f 20          	mov    r13,QWORD PTR [rdi+0x20]
ffffffff80002692:	4c 8b 77 28          	mov    r14,QWORD PTR [rdi+0x28]
ffffffff80002696:	8b 5f 30             	mov    ebx,DWORD PTR [rdi+0x30]
ffffffff80002699:	49 ff c7             	inc    r15
ffffffff8000269c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
ffffffff800026a0:	4c 89 ef             	mov    rdi,r13
ffffffff800026a3:	49 ff cf             	dec    r15
ffffffff800026a6:	74 0f                	je     ffffffff800026b7 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x2d7>
ffffffff800026a8:	89 de                	mov    esi,ebx
ffffffff800026aa:	41 ff 56 20          	call   QWORD PTR [r14+0x20]
ffffffff800026ae:	84 c0                	test   al,al
ffffffff800026b0:	74 ee                	je     ffffffff800026a0 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x2c0>
ffffffff800026b2:	40 b5 01             	mov    bpl,0x1
ffffffff800026b5:	eb 6f                	jmp    ffffffff80002726 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x346>
ffffffff800026b7:	4c 89 f6             	mov    rsi,r14
ffffffff800026ba:	89 ea                	mov    edx,ebp
ffffffff800026bc:	4c 89 e1             	mov    rcx,r12
ffffffff800026bf:	4c 8b 44 24 30       	mov    r8,QWORD PTR [rsp+0x30]
ffffffff800026c4:	e8 77 00 00 00       	call   ffffffff80002740 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h378dc09f10704491E>
ffffffff800026c9:	40 b5 01             	mov    bpl,0x1
ffffffff800026cc:	84 c0                	test   al,al
ffffffff800026ce:	75 56                	jne    ffffffff80002726 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x346>
ffffffff800026d0:	4c 89 ef             	mov    rdi,r13
ffffffff800026d3:	48 8b 74 24 18       	mov    rsi,QWORD PTR [rsp+0x18]
ffffffff800026d8:	48 8b 54 24 28       	mov    rdx,QWORD PTR [rsp+0x28]
ffffffff800026dd:	41 ff 56 18          	call   QWORD PTR [r14+0x18]
ffffffff800026e1:	84 c0                	test   al,al
ffffffff800026e3:	75 41                	jne    ffffffff80002726 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x346>
ffffffff800026e5:	48 8b 6c 24 10       	mov    rbp,QWORD PTR [rsp+0x10]
ffffffff800026ea:	49 89 ec             	mov    r12,rbp
ffffffff800026ed:	49 f7 dc             	neg    r12
ffffffff800026f0:	49 c7 c7 ff ff ff ff 	mov    r15,0xffffffffffffffff
ffffffff800026f7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
ffffffff800026fe:	00 00 
ffffffff80002700:	4b 8d 04 3c          	lea    rax,[r12+r15*1]
ffffffff80002704:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
ffffffff80002708:	74 12                	je     ffffffff8000271c <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x33c>
ffffffff8000270a:	4c 89 ef             	mov    rdi,r13
ffffffff8000270d:	89 de                	mov    esi,ebx
ffffffff8000270f:	41 ff 56 20          	call   QWORD PTR [r14+0x20]
ffffffff80002713:	49 ff c7             	inc    r15
ffffffff80002716:	84 c0                	test   al,al
ffffffff80002718:	74 e6                	je     ffffffff80002700 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x320>
ffffffff8000271a:	eb 03                	jmp    ffffffff8000271f <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E+0x33f>
ffffffff8000271c:	49 89 ef             	mov    r15,rbp
ffffffff8000271f:	49 39 ef             	cmp    r15,rbp
ffffffff80002722:	40 0f 92 c5          	setb   bpl
ffffffff80002726:	89 e8                	mov    eax,ebp
ffffffff80002728:	48 83 c4 38          	add    rsp,0x38
ffffffff8000272c:	5b                   	pop    rbx
ffffffff8000272d:	41 5c                	pop    r12
ffffffff8000272f:	41 5d                	pop    r13
ffffffff80002731:	41 5e                	pop    r14
ffffffff80002733:	41 5f                	pop    r15
ffffffff80002735:	5d                   	pop    rbp
ffffffff80002736:	c3                   	ret    
ffffffff80002737:	cc                   	int3   
ffffffff80002738:	cc                   	int3   
ffffffff80002739:	cc                   	int3   
ffffffff8000273a:	cc                   	int3   
ffffffff8000273b:	cc                   	int3   
ffffffff8000273c:	cc                   	int3   
ffffffff8000273d:	cc                   	int3   
ffffffff8000273e:	cc                   	int3   
ffffffff8000273f:	cc                   	int3   

ffffffff80002740 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h378dc09f10704491E>:
ffffffff80002740:	41 57                	push   r15
ffffffff80002742:	41 56                	push   r14
ffffffff80002744:	41 54                	push   r12
ffffffff80002746:	53                   	push   rbx
ffffffff80002747:	50                   	push   rax
ffffffff80002748:	4c 89 c3             	mov    rbx,r8
ffffffff8000274b:	49 89 ce             	mov    r14,rcx
ffffffff8000274e:	49 89 f7             	mov    r15,rsi
ffffffff80002751:	81 fa 00 00 11 00    	cmp    edx,0x110000
ffffffff80002757:	74 14                	je     ffffffff8000276d <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h378dc09f10704491E+0x2d>
ffffffff80002759:	49 89 fc             	mov    r12,rdi
ffffffff8000275c:	89 d6                	mov    esi,edx
ffffffff8000275e:	41 ff 57 20          	call   QWORD PTR [r15+0x20]
ffffffff80002762:	4c 89 e7             	mov    rdi,r12
ffffffff80002765:	89 c1                	mov    ecx,eax
ffffffff80002767:	b0 01                	mov    al,0x1
ffffffff80002769:	84 c9                	test   cl,cl
ffffffff8000276b:	75 1e                	jne    ffffffff8000278b <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h378dc09f10704491E+0x4b>
ffffffff8000276d:	4d 85 f6             	test   r14,r14
ffffffff80002770:	74 17                	je     ffffffff80002789 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h378dc09f10704491E+0x49>
ffffffff80002772:	49 8b 47 18          	mov    rax,QWORD PTR [r15+0x18]
ffffffff80002776:	4c 89 f6             	mov    rsi,r14
ffffffff80002779:	48 89 da             	mov    rdx,rbx
ffffffff8000277c:	48 83 c4 08          	add    rsp,0x8
ffffffff80002780:	5b                   	pop    rbx
ffffffff80002781:	41 5c                	pop    r12
ffffffff80002783:	41 5e                	pop    r14
ffffffff80002785:	41 5f                	pop    r15
ffffffff80002787:	ff e0                	jmp    rax
ffffffff80002789:	31 c0                	xor    eax,eax
ffffffff8000278b:	48 83 c4 08          	add    rsp,0x8
ffffffff8000278f:	5b                   	pop    rbx
ffffffff80002790:	41 5c                	pop    r12
ffffffff80002792:	41 5e                	pop    r14
ffffffff80002794:	41 5f                	pop    r15
ffffffff80002796:	c3                   	ret    
ffffffff80002797:	cc                   	int3   
ffffffff80002798:	cc                   	int3   
ffffffff80002799:	cc                   	int3   
ffffffff8000279a:	cc                   	int3   
ffffffff8000279b:	cc                   	int3   
ffffffff8000279c:	cc                   	int3   
ffffffff8000279d:	cc                   	int3   
ffffffff8000279e:	cc                   	int3   
ffffffff8000279f:	cc                   	int3   

ffffffff800027a0 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE>:
ffffffff800027a0:	55                   	push   rbp
ffffffff800027a1:	41 57                	push   r15
ffffffff800027a3:	41 56                	push   r14
ffffffff800027a5:	41 55                	push   r13
ffffffff800027a7:	41 54                	push   r12
ffffffff800027a9:	53                   	push   rbx
ffffffff800027aa:	48 83 ec 18          	sub    rsp,0x18
ffffffff800027ae:	49 89 f6             	mov    r14,rsi
ffffffff800027b1:	48 8b 07             	mov    rax,QWORD PTR [rdi]
ffffffff800027b4:	48 8b 4f 10          	mov    rcx,QWORD PTR [rdi+0x10]
ffffffff800027b8:	48 89 c6             	mov    rsi,rax
ffffffff800027bb:	48 09 ce             	or     rsi,rcx
ffffffff800027be:	0f 84 c9 04 00 00    	je     ffffffff80002c8d <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x4ed>
ffffffff800027c4:	48 85 c9             	test   rcx,rcx
ffffffff800027c7:	0f 84 9b 00 00 00    	je     ffffffff80002868 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xc8>
ffffffff800027cd:	48 8b 77 18          	mov    rsi,QWORD PTR [rdi+0x18]
ffffffff800027d1:	49 8d 1c 16          	lea    rbx,[r14+rdx*1]
ffffffff800027d5:	31 c9                	xor    ecx,ecx
ffffffff800027d7:	48 85 f6             	test   rsi,rsi
ffffffff800027da:	74 58                	je     ffffffff80002834 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x94>
ffffffff800027dc:	45 31 c0             	xor    r8d,r8d
ffffffff800027df:	4d 89 f1             	mov    r9,r14
ffffffff800027e2:	eb 24                	jmp    ffffffff80002808 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x68>
ffffffff800027e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff800027eb:	00 00 00 00 00 
ffffffff800027f0:	4d 8d 51 01          	lea    r10,[r9+0x1]
ffffffff800027f4:	49 ff c0             	inc    r8
ffffffff800027f7:	4d 89 d3             	mov    r11,r10
ffffffff800027fa:	4d 29 cb             	sub    r11,r9
ffffffff800027fd:	4c 01 d9             	add    rcx,r11
ffffffff80002800:	4d 89 d1             	mov    r9,r10
ffffffff80002803:	4c 39 c6             	cmp    rsi,r8
ffffffff80002806:	74 2f                	je     ffffffff80002837 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x97>
ffffffff80002808:	49 39 d9             	cmp    r9,rbx
ffffffff8000280b:	74 5b                	je     ffffffff80002868 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xc8>
ffffffff8000280d:	45 0f b6 11          	movzx  r10d,BYTE PTR [r9]
ffffffff80002811:	45 84 d2             	test   r10b,r10b
ffffffff80002814:	79 da                	jns    ffffffff800027f0 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x50>
ffffffff80002816:	41 80 fa e0          	cmp    r10b,0xe0
ffffffff8000281a:	72 0c                	jb     ffffffff80002828 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x88>
ffffffff8000281c:	41 80 fa f0          	cmp    r10b,0xf0
ffffffff80002820:	72 0c                	jb     ffffffff8000282e <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x8e>
ffffffff80002822:	4d 8d 51 04          	lea    r10,[r9+0x4]
ffffffff80002826:	eb cc                	jmp    ffffffff800027f4 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x54>
ffffffff80002828:	4d 8d 51 02          	lea    r10,[r9+0x2]
ffffffff8000282c:	eb c6                	jmp    ffffffff800027f4 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x54>
ffffffff8000282e:	4d 8d 51 03          	lea    r10,[r9+0x3]
ffffffff80002832:	eb c0                	jmp    ffffffff800027f4 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x54>
ffffffff80002834:	4d 89 f2             	mov    r10,r14
ffffffff80002837:	49 39 da             	cmp    r10,rbx
ffffffff8000283a:	74 2c                	je     ffffffff80002868 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xc8>
ffffffff8000283c:	41 0f b6 32          	movzx  esi,BYTE PTR [r10]
ffffffff80002840:	40 84 f6             	test   sil,sil
ffffffff80002843:	78 07                	js     ffffffff8000284c <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xac>
ffffffff80002845:	48 85 c9             	test   rcx,rcx
ffffffff80002848:	75 0b                	jne    ffffffff80002855 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xb5>
ffffffff8000284a:	eb 19                	jmp    ffffffff80002865 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xc5>
ffffffff8000284c:	40 80 fe e0          	cmp    sil,0xe0
ffffffff80002850:	48 85 c9             	test   rcx,rcx
ffffffff80002853:	74 10                	je     ffffffff80002865 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xc5>
ffffffff80002855:	48 39 d1             	cmp    rcx,rdx
ffffffff80002858:	73 09                	jae    ffffffff80002863 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xc3>
ffffffff8000285a:	41 80 3c 0e bf       	cmp    BYTE PTR [r14+rcx*1],0xbf
ffffffff8000285f:	7f 04                	jg     ffffffff80002865 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xc5>
ffffffff80002861:	eb 05                	jmp    ffffffff80002868 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xc8>
ffffffff80002863:	75 03                	jne    ffffffff80002868 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xc8>
ffffffff80002865:	48 89 ca             	mov    rdx,rcx
ffffffff80002868:	48 85 c0             	test   rax,rax
ffffffff8000286b:	0f 84 1c 04 00 00    	je     ffffffff80002c8d <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x4ed>
ffffffff80002871:	4c 8b 67 08          	mov    r12,QWORD PTR [rdi+0x8]
ffffffff80002875:	48 83 fa 20          	cmp    rdx,0x20
ffffffff80002879:	73 1a                	jae    ffffffff80002895 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0xf5>
ffffffff8000287b:	48 85 d2             	test   rdx,rdx
ffffffff8000287e:	74 5e                	je     ffffffff800028de <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x13e>
ffffffff80002880:	89 d1                	mov    ecx,edx
ffffffff80002882:	83 e1 07             	and    ecx,0x7
ffffffff80002885:	48 83 fa 08          	cmp    rdx,0x8
ffffffff80002889:	73 63                	jae    ffffffff800028ee <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x14e>
ffffffff8000288b:	31 c0                	xor    eax,eax
ffffffff8000288d:	45 31 c9             	xor    r9d,r9d
ffffffff80002890:	e9 f3 00 00 00       	jmp    ffffffff80002988 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x1e8>
ffffffff80002895:	4c 89 64 24 08       	mov    QWORD PTR [rsp+0x8],r12
ffffffff8000289a:	4d 8d 66 07          	lea    r12,[r14+0x7]
ffffffff8000289e:	49 83 e4 f8          	and    r12,0xfffffffffffffff8
ffffffff800028a2:	4c 89 e0             	mov    rax,r12
ffffffff800028a5:	4c 29 f0             	sub    rax,r14
ffffffff800028a8:	48 89 d1             	mov    rcx,rdx
ffffffff800028ab:	48 29 c1             	sub    rcx,rax
ffffffff800028ae:	89 ce                	mov    esi,ecx
ffffffff800028b0:	83 e6 07             	and    esi,0x7
ffffffff800028b3:	4c 89 e0             	mov    rax,r12
ffffffff800028b6:	4c 29 f0             	sub    rax,r14
ffffffff800028b9:	75 08                	jne    ffffffff800028c3 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x123>
ffffffff800028bb:	45 31 c0             	xor    r8d,r8d
ffffffff800028be:	e9 f4 01 00 00       	jmp    ffffffff80002ab7 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x317>
ffffffff800028c3:	4d 89 f0             	mov    r8,r14
ffffffff800028c6:	4d 29 e0             	sub    r8,r12
ffffffff800028c9:	49 83 f8 f8          	cmp    r8,0xfffffffffffffff8
ffffffff800028cd:	0f 86 20 01 00 00    	jbe    ffffffff800029f3 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x253>
ffffffff800028d3:	45 31 c0             	xor    r8d,r8d
ffffffff800028d6:	45 31 c9             	xor    r9d,r9d
ffffffff800028d9:	e9 ab 01 00 00       	jmp    ffffffff80002a89 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x2e9>
ffffffff800028de:	31 c0                	xor    eax,eax
ffffffff800028e0:	49 29 c4             	sub    r12,rax
ffffffff800028e3:	0f 87 d7 00 00 00    	ja     ffffffff800029c0 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x220>
ffffffff800028e9:	e9 9f 03 00 00       	jmp    ffffffff80002c8d <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x4ed>
ffffffff800028ee:	89 d6                	mov    esi,edx
ffffffff800028f0:	83 e6 18             	and    esi,0x18
ffffffff800028f3:	31 c0                	xor    eax,eax
ffffffff800028f5:	45 31 c9             	xor    r9d,r9d
ffffffff800028f8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
ffffffff800028ff:	00 
ffffffff80002900:	45 31 d2             	xor    r10d,r10d
ffffffff80002903:	43 80 3c 0e c0       	cmp    BYTE PTR [r14+r9*1],0xc0
ffffffff80002908:	41 0f 9d c2          	setge  r10b
ffffffff8000290c:	49 01 c2             	add    r10,rax
ffffffff8000290f:	45 31 c0             	xor    r8d,r8d
ffffffff80002912:	43 80 7c 0e 01 c0    	cmp    BYTE PTR [r14+r9*1+0x1],0xc0
ffffffff80002918:	41 0f 9d c0          	setge  r8b
ffffffff8000291c:	31 c0                	xor    eax,eax
ffffffff8000291e:	43 80 7c 0e 02 c0    	cmp    BYTE PTR [r14+r9*1+0x2],0xc0
ffffffff80002924:	0f 9d c0             	setge  al
ffffffff80002927:	4c 01 c0             	add    rax,r8
ffffffff8000292a:	4c 01 d0             	add    rax,r10
ffffffff8000292d:	45 31 d2             	xor    r10d,r10d
ffffffff80002930:	43 80 7c 0e 03 c0    	cmp    BYTE PTR [r14+r9*1+0x3],0xc0
ffffffff80002936:	41 0f 9d c2          	setge  r10b
ffffffff8000293a:	45 31 c0             	xor    r8d,r8d
ffffffff8000293d:	43 80 7c 0e 04 c0    	cmp    BYTE PTR [r14+r9*1+0x4],0xc0
ffffffff80002943:	41 0f 9d c0          	setge  r8b
ffffffff80002947:	4d 01 d0             	add    r8,r10
ffffffff8000294a:	45 31 d2             	xor    r10d,r10d
ffffffff8000294d:	43 80 7c 0e 05 c0    	cmp    BYTE PTR [r14+r9*1+0x5],0xc0
ffffffff80002953:	41 0f 9d c2          	setge  r10b
ffffffff80002957:	4d 01 c2             	add    r10,r8
ffffffff8000295a:	49 01 c2             	add    r10,rax
ffffffff8000295d:	45 31 c0             	xor    r8d,r8d
ffffffff80002960:	43 80 7c 0e 06 c0    	cmp    BYTE PTR [r14+r9*1+0x6],0xc0
ffffffff80002966:	41 0f 9d c0          	setge  r8b
ffffffff8000296a:	31 c0                	xor    eax,eax
ffffffff8000296c:	43 80 7c 0e 07 c0    	cmp    BYTE PTR [r14+r9*1+0x7],0xc0
ffffffff80002972:	0f 9d c0             	setge  al
ffffffff80002975:	4c 01 c0             	add    rax,r8
ffffffff80002978:	4c 01 d0             	add    rax,r10
ffffffff8000297b:	49 83 c1 08          	add    r9,0x8
ffffffff8000297f:	4c 39 ce             	cmp    rsi,r9
ffffffff80002982:	0f 85 78 ff ff ff    	jne    ffffffff80002900 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x160>
ffffffff80002988:	48 85 c9             	test   rcx,rcx
ffffffff8000298b:	74 2a                	je     ffffffff800029b7 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x217>
ffffffff8000298d:	4d 01 f1             	add    r9,r14
ffffffff80002990:	31 f6                	xor    esi,esi
ffffffff80002992:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80002999:	1f 84 00 00 00 00 00 
ffffffff800029a0:	45 31 c0             	xor    r8d,r8d
ffffffff800029a3:	41 80 3c 31 c0       	cmp    BYTE PTR [r9+rsi*1],0xc0
ffffffff800029a8:	41 0f 9d c0          	setge  r8b
ffffffff800029ac:	4c 01 c0             	add    rax,r8
ffffffff800029af:	48 ff c6             	inc    rsi
ffffffff800029b2:	48 39 f1             	cmp    rcx,rsi
ffffffff800029b5:	75 e9                	jne    ffffffff800029a0 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x200>
ffffffff800029b7:	49 29 c4             	sub    r12,rax
ffffffff800029ba:	0f 86 cd 02 00 00    	jbe    ffffffff80002c8d <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x4ed>
ffffffff800029c0:	0f b6 47 38          	movzx  eax,BYTE PTR [rdi+0x38]
ffffffff800029c4:	48 8d 0d 2d 1e 00 00 	lea    rcx,[rip+0x1e2d]        # ffffffff800047f8 <memset+0x1018>
ffffffff800029cb:	48 63 04 81          	movsxd rax,DWORD PTR [rcx+rax*4]
ffffffff800029cf:	48 01 c8             	add    rax,rcx
ffffffff800029d2:	ff e0                	jmp    rax
ffffffff800029d4:	48 89 d3             	mov    rbx,rdx
ffffffff800029d7:	4c 89 64 24 08       	mov    QWORD PTR [rsp+0x8],r12
ffffffff800029dc:	45 31 e4             	xor    r12d,r12d
ffffffff800029df:	e9 20 03 00 00       	jmp    ffffffff80002d04 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x564>
ffffffff800029e4:	48 89 d3             	mov    rbx,rdx
ffffffff800029e7:	31 c0                	xor    eax,eax
ffffffff800029e9:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
ffffffff800029ee:	e9 11 03 00 00       	jmp    ffffffff80002d04 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x564>
ffffffff800029f3:	45 31 c0             	xor    r8d,r8d
ffffffff800029f6:	45 31 c9             	xor    r9d,r9d
ffffffff800029f9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
ffffffff80002a00:	45 31 d2             	xor    r10d,r10d
ffffffff80002a03:	43 80 3c 0e c0       	cmp    BYTE PTR [r14+r9*1],0xc0
ffffffff80002a08:	41 0f 9d c2          	setge  r10b
ffffffff80002a0c:	4d 01 c2             	add    r10,r8
ffffffff80002a0f:	45 31 db             	xor    r11d,r11d
ffffffff80002a12:	43 80 7c 0e 01 c0    	cmp    BYTE PTR [r14+r9*1+0x1],0xc0
ffffffff80002a18:	41 0f 9d c3          	setge  r11b
ffffffff80002a1c:	45 31 c0             	xor    r8d,r8d
ffffffff80002a1f:	43 80 7c 0e 02 c0    	cmp    BYTE PTR [r14+r9*1+0x2],0xc0
ffffffff80002a25:	41 0f 9d c0          	setge  r8b
ffffffff80002a29:	4d 01 d8             	add    r8,r11
ffffffff80002a2c:	4d 01 d0             	add    r8,r10
ffffffff80002a2f:	45 31 d2             	xor    r10d,r10d
ffffffff80002a32:	43 80 7c 0e 03 c0    	cmp    BYTE PTR [r14+r9*1+0x3],0xc0
ffffffff80002a38:	41 0f 9d c2          	setge  r10b
ffffffff80002a3c:	45 31 db             	xor    r11d,r11d
ffffffff80002a3f:	43 80 7c 0e 04 c0    	cmp    BYTE PTR [r14+r9*1+0x4],0xc0
ffffffff80002a45:	41 0f 9d c3          	setge  r11b
ffffffff80002a49:	4d 01 d3             	add    r11,r10
ffffffff80002a4c:	45 31 d2             	xor    r10d,r10d
ffffffff80002a4f:	43 80 7c 0e 05 c0    	cmp    BYTE PTR [r14+r9*1+0x5],0xc0
ffffffff80002a55:	41 0f 9d c2          	setge  r10b
ffffffff80002a59:	4d 01 da             	add    r10,r11
ffffffff80002a5c:	4d 01 c2             	add    r10,r8
ffffffff80002a5f:	45 31 db             	xor    r11d,r11d
ffffffff80002a62:	43 80 7c 0e 06 c0    	cmp    BYTE PTR [r14+r9*1+0x6],0xc0
ffffffff80002a68:	41 0f 9d c3          	setge  r11b
ffffffff80002a6c:	45 31 c0             	xor    r8d,r8d
ffffffff80002a6f:	43 80 7c 0e 07 c0    	cmp    BYTE PTR [r14+r9*1+0x7],0xc0
ffffffff80002a75:	41 0f 9d c0          	setge  r8b
ffffffff80002a79:	4d 01 d8             	add    r8,r11
ffffffff80002a7c:	4d 01 d0             	add    r8,r10
ffffffff80002a7f:	49 83 c1 08          	add    r9,0x8
ffffffff80002a83:	0f 85 77 ff ff ff    	jne    ffffffff80002a00 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x260>
ffffffff80002a89:	4d 39 f4             	cmp    r12,r14
ffffffff80002a8c:	74 29                	je     ffffffff80002ab7 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x317>
ffffffff80002a8e:	4d 01 f1             	add    r9,r14
ffffffff80002a91:	45 31 d2             	xor    r10d,r10d
ffffffff80002a94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80002a9b:	00 00 00 00 00 
ffffffff80002aa0:	45 31 db             	xor    r11d,r11d
ffffffff80002aa3:	43 80 3c 11 c0       	cmp    BYTE PTR [r9+r10*1],0xc0
ffffffff80002aa8:	41 0f 9d c3          	setge  r11b
ffffffff80002aac:	4d 01 d8             	add    r8,r11
ffffffff80002aaf:	49 ff c2             	inc    r10
ffffffff80002ab2:	4c 39 d0             	cmp    rax,r10
ffffffff80002ab5:	75 e9                	jne    ffffffff80002aa0 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x300>
ffffffff80002ab7:	48 85 f6             	test   rsi,rsi
ffffffff80002aba:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
ffffffff80002abf:	0f 84 90 00 00 00    	je     ffffffff80002b55 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3b5>
ffffffff80002ac5:	49 89 c9             	mov    r9,rcx
ffffffff80002ac8:	49 83 e1 f8          	and    r9,0xfffffffffffffff8
ffffffff80002acc:	31 c0                	xor    eax,eax
ffffffff80002ace:	43 80 3c 0c c0       	cmp    BYTE PTR [r12+r9*1],0xc0
ffffffff80002ad3:	0f 9d c0             	setge  al
ffffffff80002ad6:	83 fe 01             	cmp    esi,0x1
ffffffff80002ad9:	74 7c                	je     ffffffff80002b57 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3b7>
ffffffff80002adb:	45 31 d2             	xor    r10d,r10d
ffffffff80002ade:	43 80 7c 0c 01 c0    	cmp    BYTE PTR [r12+r9*1+0x1],0xc0
ffffffff80002ae4:	41 0f 9d c2          	setge  r10b
ffffffff80002ae8:	4c 01 d0             	add    rax,r10
ffffffff80002aeb:	83 fe 02             	cmp    esi,0x2
ffffffff80002aee:	74 67                	je     ffffffff80002b57 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3b7>
ffffffff80002af0:	45 31 d2             	xor    r10d,r10d
ffffffff80002af3:	43 80 7c 0c 02 c0    	cmp    BYTE PTR [r12+r9*1+0x2],0xc0
ffffffff80002af9:	41 0f 9d c2          	setge  r10b
ffffffff80002afd:	4c 01 d0             	add    rax,r10
ffffffff80002b00:	83 fe 03             	cmp    esi,0x3
ffffffff80002b03:	74 52                	je     ffffffff80002b57 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3b7>
ffffffff80002b05:	45 31 d2             	xor    r10d,r10d
ffffffff80002b08:	43 80 7c 0c 03 c0    	cmp    BYTE PTR [r12+r9*1+0x3],0xc0
ffffffff80002b0e:	41 0f 9d c2          	setge  r10b
ffffffff80002b12:	4c 01 d0             	add    rax,r10
ffffffff80002b15:	83 fe 04             	cmp    esi,0x4
ffffffff80002b18:	74 3d                	je     ffffffff80002b57 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3b7>
ffffffff80002b1a:	45 31 d2             	xor    r10d,r10d
ffffffff80002b1d:	43 80 7c 0c 04 c0    	cmp    BYTE PTR [r12+r9*1+0x4],0xc0
ffffffff80002b23:	41 0f 9d c2          	setge  r10b
ffffffff80002b27:	4c 01 d0             	add    rax,r10
ffffffff80002b2a:	83 fe 05             	cmp    esi,0x5
ffffffff80002b2d:	74 28                	je     ffffffff80002b57 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3b7>
ffffffff80002b2f:	45 31 d2             	xor    r10d,r10d
ffffffff80002b32:	43 80 7c 0c 05 c0    	cmp    BYTE PTR [r12+r9*1+0x5],0xc0
ffffffff80002b38:	41 0f 9d c2          	setge  r10b
ffffffff80002b3c:	4c 01 d0             	add    rax,r10
ffffffff80002b3f:	83 fe 06             	cmp    esi,0x6
ffffffff80002b42:	74 13                	je     ffffffff80002b57 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3b7>
ffffffff80002b44:	31 f6                	xor    esi,esi
ffffffff80002b46:	43 80 7c 0c 06 c0    	cmp    BYTE PTR [r12+r9*1+0x6],0xc0
ffffffff80002b4c:	40 0f 9d c6          	setge  sil
ffffffff80002b50:	48 01 f0             	add    rax,rsi
ffffffff80002b53:	eb 02                	jmp    ffffffff80002b57 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3b7>
ffffffff80002b55:	31 c0                	xor    eax,eax
ffffffff80002b57:	4c 01 c0             	add    rax,r8
ffffffff80002b5a:	48 c1 e9 03          	shr    rcx,0x3
ffffffff80002b5e:	49 b9 01 01 01 01 01 	movabs r9,0x101010101010101
ffffffff80002b65:	01 01 01 
ffffffff80002b68:	48 ba 01 00 01 00 01 	movabs rdx,0x1000100010001
ffffffff80002b6f:	00 01 00 
ffffffff80002b72:	eb 4a                	jmp    ffffffff80002bbe <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x41e>
ffffffff80002b74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80002b7b:	00 00 00 00 00 
ffffffff80002b80:	45 31 ed             	xor    r13d,r13d
ffffffff80002b83:	4d 01 d4             	add    r12,r10
ffffffff80002b86:	4c 29 d9             	sub    rcx,r11
ffffffff80002b89:	45 89 df             	mov    r15d,r11d
ffffffff80002b8c:	41 83 e7 03          	and    r15d,0x3
ffffffff80002b90:	4c 89 ee             	mov    rsi,r13
ffffffff80002b93:	49 b8 ff 00 ff 00 ff 	movabs r8,0xff00ff00ff00ff
ffffffff80002b9a:	00 ff 00 
ffffffff80002b9d:	4c 21 c6             	and    rsi,r8
ffffffff80002ba0:	49 c1 ed 08          	shr    r13,0x8
ffffffff80002ba4:	4d 21 c5             	and    r13,r8
ffffffff80002ba7:	49 01 f5             	add    r13,rsi
ffffffff80002baa:	4c 0f af ea          	imul   r13,rdx
ffffffff80002bae:	49 c1 ed 30          	shr    r13,0x30
ffffffff80002bb2:	4c 01 e8             	add    rax,r13
ffffffff80002bb5:	4d 85 ff             	test   r15,r15
ffffffff80002bb8:	0f 85 f1 00 00 00    	jne    ffffffff80002caf <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x50f>
ffffffff80002bbe:	48 85 c9             	test   rcx,rcx
ffffffff80002bc1:	0f 84 b3 00 00 00    	je     ffffffff80002c7a <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x4da>
ffffffff80002bc7:	4d 89 e2             	mov    r10,r12
ffffffff80002bca:	48 81 f9 c0 00 00 00 	cmp    rcx,0xc0
ffffffff80002bd1:	41 bb c0 00 00 00    	mov    r11d,0xc0
ffffffff80002bd7:	4c 0f 42 d9          	cmovb  r11,rcx
ffffffff80002bdb:	46 8d 24 dd 00 00 00 	lea    r12d,[r11*8+0x0]
ffffffff80002be2:	00 
ffffffff80002be3:	48 83 f9 04          	cmp    rcx,0x4
ffffffff80002be7:	72 97                	jb     ffffffff80002b80 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3e0>
ffffffff80002be9:	45 89 e7             	mov    r15d,r12d
ffffffff80002bec:	41 81 e7 e0 07 00 00 	and    r15d,0x7e0
ffffffff80002bf3:	4d 01 d7             	add    r15,r10
ffffffff80002bf6:	45 31 ed             	xor    r13d,r13d
ffffffff80002bf9:	4c 89 d5             	mov    rbp,r10
ffffffff80002bfc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
ffffffff80002c00:	4c 8b 45 00          	mov    r8,QWORD PTR [rbp+0x0]
ffffffff80002c04:	48 8b 75 08          	mov    rsi,QWORD PTR [rbp+0x8]
ffffffff80002c08:	4c 89 c3             	mov    rbx,r8
ffffffff80002c0b:	48 f7 d3             	not    rbx
ffffffff80002c0e:	48 c1 eb 07          	shr    rbx,0x7
ffffffff80002c12:	49 c1 e8 06          	shr    r8,0x6
ffffffff80002c16:	49 09 d8             	or     r8,rbx
ffffffff80002c19:	4d 21 c8             	and    r8,r9
ffffffff80002c1c:	4d 01 e8             	add    r8,r13
ffffffff80002c1f:	48 89 f3             	mov    rbx,rsi
ffffffff80002c22:	48 f7 d3             	not    rbx
ffffffff80002c25:	48 c1 eb 07          	shr    rbx,0x7
ffffffff80002c29:	48 c1 ee 06          	shr    rsi,0x6
ffffffff80002c2d:	48 09 de             	or     rsi,rbx
ffffffff80002c30:	4c 21 ce             	and    rsi,r9
ffffffff80002c33:	48 8b 5d 10          	mov    rbx,QWORD PTR [rbp+0x10]
ffffffff80002c37:	49 89 dd             	mov    r13,rbx
ffffffff80002c3a:	49 f7 d5             	not    r13
ffffffff80002c3d:	49 c1 ed 07          	shr    r13,0x7
ffffffff80002c41:	48 c1 eb 06          	shr    rbx,0x6
ffffffff80002c45:	4c 09 eb             	or     rbx,r13
ffffffff80002c48:	4c 21 cb             	and    rbx,r9
ffffffff80002c4b:	48 01 f3             	add    rbx,rsi
ffffffff80002c4e:	4c 01 c3             	add    rbx,r8
ffffffff80002c51:	4c 8b 6d 18          	mov    r13,QWORD PTR [rbp+0x18]
ffffffff80002c55:	4c 89 ee             	mov    rsi,r13
ffffffff80002c58:	48 f7 d6             	not    rsi
ffffffff80002c5b:	48 c1 ee 07          	shr    rsi,0x7
ffffffff80002c5f:	49 c1 ed 06          	shr    r13,0x6
ffffffff80002c63:	49 09 f5             	or     r13,rsi
ffffffff80002c66:	4d 21 cd             	and    r13,r9
ffffffff80002c69:	49 01 dd             	add    r13,rbx
ffffffff80002c6c:	48 83 c5 20          	add    rbp,0x20
ffffffff80002c70:	4c 39 fd             	cmp    rbp,r15
ffffffff80002c73:	75 8b                	jne    ffffffff80002c00 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x460>
ffffffff80002c75:	e9 09 ff ff ff       	jmp    ffffffff80002b83 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x3e3>
ffffffff80002c7a:	48 8b 54 24 10       	mov    rdx,QWORD PTR [rsp+0x10]
ffffffff80002c7f:	4c 8b 64 24 08       	mov    r12,QWORD PTR [rsp+0x8]
ffffffff80002c84:	49 29 c4             	sub    r12,rax
ffffffff80002c87:	0f 87 33 fd ff ff    	ja     ffffffff800029c0 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x220>
ffffffff80002c8d:	48 8b 47 20          	mov    rax,QWORD PTR [rdi+0x20]
ffffffff80002c91:	48 8b 4f 28          	mov    rcx,QWORD PTR [rdi+0x28]
ffffffff80002c95:	48 8b 49 18          	mov    rcx,QWORD PTR [rcx+0x18]
ffffffff80002c99:	48 89 c7             	mov    rdi,rax
ffffffff80002c9c:	4c 89 f6             	mov    rsi,r14
ffffffff80002c9f:	48 83 c4 18          	add    rsp,0x18
ffffffff80002ca3:	5b                   	pop    rbx
ffffffff80002ca4:	41 5c                	pop    r12
ffffffff80002ca6:	41 5d                	pop    r13
ffffffff80002ca8:	41 5e                	pop    r14
ffffffff80002caa:	41 5f                	pop    r15
ffffffff80002cac:	5d                   	pop    rbp
ffffffff80002cad:	ff e1                	jmp    rcx
ffffffff80002caf:	49 89 d0             	mov    r8,rdx
ffffffff80002cb2:	41 81 e3 fc 00 00 00 	and    r11d,0xfc
ffffffff80002cb9:	44 89 d9             	mov    ecx,r11d
ffffffff80002cbc:	49 8b 0c ca          	mov    rcx,QWORD PTR [r10+rcx*8]
ffffffff80002cc0:	48 89 ca             	mov    rdx,rcx
ffffffff80002cc3:	48 f7 d2             	not    rdx
ffffffff80002cc6:	48 c1 ea 07          	shr    rdx,0x7
ffffffff80002cca:	48 c1 e9 06          	shr    rcx,0x6
ffffffff80002cce:	48 09 d1             	or     rcx,rdx
ffffffff80002cd1:	4c 21 c9             	and    rcx,r9
ffffffff80002cd4:	41 83 ff 01          	cmp    r15d,0x1
ffffffff80002cd8:	0f 85 b2 00 00 00    	jne    ffffffff80002d90 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x5f0>
ffffffff80002cde:	48 8b 54 24 10       	mov    rdx,QWORD PTR [rsp+0x10]
ffffffff80002ce3:	4c 8b 64 24 08       	mov    r12,QWORD PTR [rsp+0x8]
ffffffff80002ce8:	e9 eb 00 00 00       	jmp    ffffffff80002dd8 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x638>
ffffffff80002ced:	48 89 d3             	mov    rbx,rdx
ffffffff80002cf0:	4c 89 e0             	mov    rax,r12
ffffffff80002cf3:	48 d1 e8             	shr    rax,1
ffffffff80002cf6:	49 ff c4             	inc    r12
ffffffff80002cf9:	49 d1 ec             	shr    r12,1
ffffffff80002cfc:	4c 89 64 24 08       	mov    QWORD PTR [rsp+0x8],r12
ffffffff80002d01:	49 89 c4             	mov    r12,rax
ffffffff80002d04:	4c 8b 7f 20          	mov    r15,QWORD PTR [rdi+0x20]
ffffffff80002d08:	4c 8b 6f 28          	mov    r13,QWORD PTR [rdi+0x28]
ffffffff80002d0c:	8b 6f 30             	mov    ebp,DWORD PTR [rdi+0x30]
ffffffff80002d0f:	49 ff c4             	inc    r12
ffffffff80002d12:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80002d19:	1f 84 00 00 00 00 00 
ffffffff80002d20:	4c 89 ff             	mov    rdi,r15
ffffffff80002d23:	49 ff cc             	dec    r12
ffffffff80002d26:	74 11                	je     ffffffff80002d39 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x599>
ffffffff80002d28:	89 ee                	mov    esi,ebp
ffffffff80002d2a:	41 ff 55 20          	call   QWORD PTR [r13+0x20]
ffffffff80002d2e:	84 c0                	test   al,al
ffffffff80002d30:	74 ee                	je     ffffffff80002d20 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x580>
ffffffff80002d32:	b0 01                	mov    al,0x1
ffffffff80002d34:	e9 db 00 00 00       	jmp    ffffffff80002e14 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x674>
ffffffff80002d39:	4c 89 f6             	mov    rsi,r14
ffffffff80002d3c:	48 89 da             	mov    rdx,rbx
ffffffff80002d3f:	41 ff 55 18          	call   QWORD PTR [r13+0x18]
ffffffff80002d43:	89 c1                	mov    ecx,eax
ffffffff80002d45:	b0 01                	mov    al,0x1
ffffffff80002d47:	84 c9                	test   cl,cl
ffffffff80002d49:	0f 85 c5 00 00 00    	jne    ffffffff80002e14 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x674>
ffffffff80002d4f:	4c 8b 64 24 08       	mov    r12,QWORD PTR [rsp+0x8]
ffffffff80002d54:	4d 89 e6             	mov    r14,r12
ffffffff80002d57:	49 f7 de             	neg    r14
ffffffff80002d5a:	48 c7 c3 ff ff ff ff 	mov    rbx,0xffffffffffffffff
ffffffff80002d61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80002d68:	0f 1f 84 00 00 00 00 
ffffffff80002d6f:	00 
ffffffff80002d70:	49 8d 04 1e          	lea    rax,[r14+rbx*1]
ffffffff80002d74:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
ffffffff80002d78:	0f 84 8d 00 00 00    	je     ffffffff80002e0b <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x66b>
ffffffff80002d7e:	4c 89 ff             	mov    rdi,r15
ffffffff80002d81:	89 ee                	mov    esi,ebp
ffffffff80002d83:	41 ff 55 20          	call   QWORD PTR [r13+0x20]
ffffffff80002d87:	48 ff c3             	inc    rbx
ffffffff80002d8a:	84 c0                	test   al,al
ffffffff80002d8c:	74 e2                	je     ffffffff80002d70 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x5d0>
ffffffff80002d8e:	eb 7e                	jmp    ffffffff80002e0e <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x66e>
ffffffff80002d90:	4b 8b 54 da 08       	mov    rdx,QWORD PTR [r10+r11*8+0x8]
ffffffff80002d95:	48 89 d6             	mov    rsi,rdx
ffffffff80002d98:	48 f7 d6             	not    rsi
ffffffff80002d9b:	48 c1 ee 07          	shr    rsi,0x7
ffffffff80002d9f:	48 c1 ea 06          	shr    rdx,0x6
ffffffff80002da3:	48 09 f2             	or     rdx,rsi
ffffffff80002da6:	4c 21 ca             	and    rdx,r9
ffffffff80002da9:	48 01 d1             	add    rcx,rdx
ffffffff80002dac:	41 83 ff 02          	cmp    r15d,0x2
ffffffff80002db0:	4c 8b 64 24 08       	mov    r12,QWORD PTR [rsp+0x8]
ffffffff80002db5:	74 1c                	je     ffffffff80002dd3 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x633>
ffffffff80002db7:	4b 8b 54 da 10       	mov    rdx,QWORD PTR [r10+r11*8+0x10]
ffffffff80002dbc:	48 89 d6             	mov    rsi,rdx
ffffffff80002dbf:	48 f7 d6             	not    rsi
ffffffff80002dc2:	48 c1 ee 07          	shr    rsi,0x7
ffffffff80002dc6:	48 c1 ea 06          	shr    rdx,0x6
ffffffff80002dca:	48 09 f2             	or     rdx,rsi
ffffffff80002dcd:	4c 21 ca             	and    rdx,r9
ffffffff80002dd0:	48 01 d1             	add    rcx,rdx
ffffffff80002dd3:	48 8b 54 24 10       	mov    rdx,QWORD PTR [rsp+0x10]
ffffffff80002dd8:	48 89 ce             	mov    rsi,rcx
ffffffff80002ddb:	49 b9 ff 00 ff 00 ff 	movabs r9,0xff00ff00ff00ff
ffffffff80002de2:	00 ff 00 
ffffffff80002de5:	4c 21 ce             	and    rsi,r9
ffffffff80002de8:	48 c1 e9 08          	shr    rcx,0x8
ffffffff80002dec:	4c 21 c9             	and    rcx,r9
ffffffff80002def:	48 01 f1             	add    rcx,rsi
ffffffff80002df2:	49 0f af c8          	imul   rcx,r8
ffffffff80002df6:	48 c1 e9 30          	shr    rcx,0x30
ffffffff80002dfa:	48 01 c8             	add    rax,rcx
ffffffff80002dfd:	49 29 c4             	sub    r12,rax
ffffffff80002e00:	0f 87 ba fb ff ff    	ja     ffffffff800029c0 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x220>
ffffffff80002e06:	e9 82 fe ff ff       	jmp    ffffffff80002c8d <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE+0x4ed>
ffffffff80002e0b:	4c 89 e3             	mov    rbx,r12
ffffffff80002e0e:	4c 39 e3             	cmp    rbx,r12
ffffffff80002e11:	0f 92 c0             	setb   al
ffffffff80002e14:	48 83 c4 18          	add    rsp,0x18
ffffffff80002e18:	5b                   	pop    rbx
ffffffff80002e19:	41 5c                	pop    r12
ffffffff80002e1b:	41 5d                	pop    r13
ffffffff80002e1d:	41 5e                	pop    r14
ffffffff80002e1f:	41 5f                	pop    r15
ffffffff80002e21:	5d                   	pop    rbp
ffffffff80002e22:	c3                   	ret    
ffffffff80002e23:	cc                   	int3   
ffffffff80002e24:	cc                   	int3   
ffffffff80002e25:	cc                   	int3   
ffffffff80002e26:	cc                   	int3   
ffffffff80002e27:	cc                   	int3   
ffffffff80002e28:	cc                   	int3   
ffffffff80002e29:	cc                   	int3   
ffffffff80002e2a:	cc                   	int3   
ffffffff80002e2b:	cc                   	int3   
ffffffff80002e2c:	cc                   	int3   
ffffffff80002e2d:	cc                   	int3   
ffffffff80002e2e:	cc                   	int3   
ffffffff80002e2f:	cc                   	int3   

ffffffff80002e30 <_ZN4core9panicking5panic17h46e4bc2a84108c31E>:
ffffffff80002e30:	48 83 ec 48          	sub    rsp,0x48
ffffffff80002e34:	48 8d 05 39 35 00 00 	lea    rax,[rip+0x3539]        # ffffffff80006374 <memset+0x2b94>
ffffffff80002e3b:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
ffffffff80002e40:	48 c7 44 24 10 2e 00 	mov    QWORD PTR [rsp+0x10],0x2e
ffffffff80002e47:	00 00 
ffffffff80002e49:	48 8d 44 24 08       	lea    rax,[rsp+0x8]
ffffffff80002e4e:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff80002e53:	48 c7 44 24 20 01 00 	mov    QWORD PTR [rsp+0x20],0x1
ffffffff80002e5a:	00 00 
ffffffff80002e5c:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
ffffffff80002e63:	00 00 
ffffffff80002e65:	48 c7 44 24 28 08 00 	mov    QWORD PTR [rsp+0x28],0x8
ffffffff80002e6c:	00 00 
ffffffff80002e6e:	48 c7 44 24 30 00 00 	mov    QWORD PTR [rsp+0x30],0x0
ffffffff80002e75:	00 00 
ffffffff80002e77:	48 8d 35 ca 32 01 00 	lea    rsi,[rip+0x132ca]        # ffffffff80016148 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x68>
ffffffff80002e7e:	48 8d 7c 24 18       	lea    rdi,[rsp+0x18]
ffffffff80002e83:	e8 e8 f2 ff ff       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80002e88:	cc                   	int3   
ffffffff80002e89:	cc                   	int3   
ffffffff80002e8a:	cc                   	int3   
ffffffff80002e8b:	cc                   	int3   
ffffffff80002e8c:	cc                   	int3   
ffffffff80002e8d:	cc                   	int3   
ffffffff80002e8e:	cc                   	int3   
ffffffff80002e8f:	cc                   	int3   

ffffffff80002e90 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h5edd5340cb38599eE>:
ffffffff80002e90:	48 89 f0             	mov    rax,rsi
ffffffff80002e93:	48 8b 37             	mov    rsi,QWORD PTR [rdi]
ffffffff80002e96:	48 8b 57 08          	mov    rdx,QWORD PTR [rdi+0x8]
ffffffff80002e9a:	48 89 c7             	mov    rdi,rax
ffffffff80002e9d:	e9 fe f8 ff ff       	jmp    ffffffff800027a0 <_ZN4core3fmt9Formatter3pad17h4f535732df691f7bE>
ffffffff80002ea2:	cc                   	int3   
ffffffff80002ea3:	cc                   	int3   
ffffffff80002ea4:	cc                   	int3   
ffffffff80002ea5:	cc                   	int3   
ffffffff80002ea6:	cc                   	int3   
ffffffff80002ea7:	cc                   	int3   
ffffffff80002ea8:	cc                   	int3   
ffffffff80002ea9:	cc                   	int3   
ffffffff80002eaa:	cc                   	int3   
ffffffff80002eab:	cc                   	int3   
ffffffff80002eac:	cc                   	int3   
ffffffff80002ead:	cc                   	int3   
ffffffff80002eae:	cc                   	int3   
ffffffff80002eaf:	cc                   	int3   

ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>:
ffffffff80002eb0:	55                   	push   rbp
ffffffff80002eb1:	41 57                	push   r15
ffffffff80002eb3:	41 56                	push   r14
ffffffff80002eb5:	41 55                	push   r13
ffffffff80002eb7:	41 54                	push   r12
ffffffff80002eb9:	53                   	push   rbx
ffffffff80002eba:	48 83 ec 48          	sub    rsp,0x48
ffffffff80002ebe:	48 c7 44 24 38 20 00 	mov    QWORD PTR [rsp+0x38],0x20
ffffffff80002ec5:	00 00 
ffffffff80002ec7:	c6 44 24 40 03       	mov    BYTE PTR [rsp+0x40],0x3
ffffffff80002ecc:	48 c7 44 24 08 00 00 	mov    QWORD PTR [rsp+0x8],0x0
ffffffff80002ed3:	00 00 
ffffffff80002ed5:	48 c7 44 24 18 00 00 	mov    QWORD PTR [rsp+0x18],0x0
ffffffff80002edc:	00 00 
ffffffff80002ede:	48 89 7c 24 28       	mov    QWORD PTR [rsp+0x28],rdi
ffffffff80002ee3:	48 89 74 24 30       	mov    QWORD PTR [rsp+0x30],rsi
ffffffff80002ee8:	4c 8b 62 20          	mov    r12,QWORD PTR [rdx+0x20]
ffffffff80002eec:	4d 85 e4             	test   r12,r12
ffffffff80002eef:	48 89 14 24          	mov    QWORD PTR [rsp],rdx
ffffffff80002ef3:	0f 84 0c 01 00 00    	je     ffffffff80003005 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x155>
ffffffff80002ef9:	48 8b 42 28          	mov    rax,QWORD PTR [rdx+0x28]
ffffffff80002efd:	48 85 c0             	test   rax,rax
ffffffff80002f00:	0f 84 68 01 00 00    	je     ffffffff8000306e <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1be>
ffffffff80002f06:	4c 8b 2a             	mov    r13,QWORD PTR [rdx]
ffffffff80002f09:	48 8b 6a 10          	mov    rbp,QWORD PTR [rdx+0x10]
ffffffff80002f0d:	49 83 c5 08          	add    r13,0x8
ffffffff80002f11:	4c 6b f0 38          	imul   r14,rax,0x38
ffffffff80002f15:	31 db                	xor    ebx,ebx
ffffffff80002f17:	45 31 ff             	xor    r15d,r15d
ffffffff80002f1a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
ffffffff80002f20:	49 8b 55 00          	mov    rdx,QWORD PTR [r13+0x0]
ffffffff80002f24:	48 85 d2             	test   rdx,rdx
ffffffff80002f27:	74 19                	je     ffffffff80002f42 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x92>
ffffffff80002f29:	48 8b 7c 24 28       	mov    rdi,QWORD PTR [rsp+0x28]
ffffffff80002f2e:	48 8b 44 24 30       	mov    rax,QWORD PTR [rsp+0x30]
ffffffff80002f33:	49 8b 75 f8          	mov    rsi,QWORD PTR [r13-0x8]
ffffffff80002f37:	ff 50 18             	call   QWORD PTR [rax+0x18]
ffffffff80002f3a:	84 c0                	test   al,al
ffffffff80002f3c:	0f 85 5e 01 00 00    	jne    ffffffff800030a0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1f0>
ffffffff80002f42:	41 8b 44 1c 28       	mov    eax,DWORD PTR [r12+rbx*1+0x28]
ffffffff80002f47:	89 44 24 38          	mov    DWORD PTR [rsp+0x38],eax
ffffffff80002f4b:	41 0f b6 44 1c 30    	movzx  eax,BYTE PTR [r12+rbx*1+0x30]
ffffffff80002f51:	88 44 24 40          	mov    BYTE PTR [rsp+0x40],al
ffffffff80002f55:	41 8b 44 1c 2c       	mov    eax,DWORD PTR [r12+rbx*1+0x2c]
ffffffff80002f5a:	89 44 24 3c          	mov    DWORD PTR [rsp+0x3c],eax
ffffffff80002f5e:	49 8b 4c 1c 10       	mov    rcx,QWORD PTR [r12+rbx*1+0x10]
ffffffff80002f63:	49 8b 44 1c 18       	mov    rax,QWORD PTR [r12+rbx*1+0x18]
ffffffff80002f68:	48 85 c9             	test   rcx,rcx
ffffffff80002f6b:	74 1b                	je     ffffffff80002f88 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0xd8>
ffffffff80002f6d:	83 f9 01             	cmp    ecx,0x1
ffffffff80002f70:	75 0c                	jne    ffffffff80002f7e <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0xce>
ffffffff80002f72:	48 c1 e0 04          	shl    rax,0x4
ffffffff80002f76:	48 83 7c 05 08 00    	cmp    QWORD PTR [rbp+rax*1+0x8],0x0
ffffffff80002f7c:	74 04                	je     ffffffff80002f82 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0xd2>
ffffffff80002f7e:	31 c9                	xor    ecx,ecx
ffffffff80002f80:	eb 0b                	jmp    ffffffff80002f8d <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0xdd>
ffffffff80002f82:	48 01 e8             	add    rax,rbp
ffffffff80002f85:	48 8b 00             	mov    rax,QWORD PTR [rax]
ffffffff80002f88:	b9 01 00 00 00       	mov    ecx,0x1
ffffffff80002f8d:	48 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],rcx
ffffffff80002f92:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff80002f97:	49 8b 0c 1c          	mov    rcx,QWORD PTR [r12+rbx*1]
ffffffff80002f9b:	48 83 f9 02          	cmp    rcx,0x2
ffffffff80002f9f:	74 16                	je     ffffffff80002fb7 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x107>
ffffffff80002fa1:	49 8b 44 1c 08       	mov    rax,QWORD PTR [r12+rbx*1+0x8]
ffffffff80002fa6:	83 f9 01             	cmp    ecx,0x1
ffffffff80002fa9:	75 16                	jne    ffffffff80002fc1 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x111>
ffffffff80002fab:	48 c1 e0 04          	shl    rax,0x4
ffffffff80002faf:	48 83 7c 05 08 00    	cmp    QWORD PTR [rbp+rax*1+0x8],0x0
ffffffff80002fb5:	74 04                	je     ffffffff80002fbb <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x10b>
ffffffff80002fb7:	31 c9                	xor    ecx,ecx
ffffffff80002fb9:	eb 0b                	jmp    ffffffff80002fc6 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x116>
ffffffff80002fbb:	48 01 e8             	add    rax,rbp
ffffffff80002fbe:	48 8b 00             	mov    rax,QWORD PTR [rax]
ffffffff80002fc1:	b9 01 00 00 00       	mov    ecx,0x1
ffffffff80002fc6:	48 89 4c 24 18       	mov    QWORD PTR [rsp+0x18],rcx
ffffffff80002fcb:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff80002fd0:	49 8b 44 1c 20       	mov    rax,QWORD PTR [r12+rbx*1+0x20]
ffffffff80002fd5:	48 c1 e0 04          	shl    rax,0x4
ffffffff80002fd9:	48 8b 7c 05 00       	mov    rdi,QWORD PTR [rbp+rax*1+0x0]
ffffffff80002fde:	48 8d 74 24 08       	lea    rsi,[rsp+0x8]
ffffffff80002fe3:	ff 54 05 08          	call   QWORD PTR [rbp+rax*1+0x8]
ffffffff80002fe7:	84 c0                	test   al,al
ffffffff80002fe9:	0f 85 b1 00 00 00    	jne    ffffffff800030a0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1f0>
ffffffff80002fef:	49 83 c5 10          	add    r13,0x10
ffffffff80002ff3:	48 83 c3 38          	add    rbx,0x38
ffffffff80002ff7:	49 ff c7             	inc    r15
ffffffff80002ffa:	49 39 de             	cmp    r14,rbx
ffffffff80002ffd:	0f 85 1d ff ff ff    	jne    ffffffff80002f20 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x70>
ffffffff80003003:	eb 6c                	jmp    ffffffff80003071 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1c1>
ffffffff80003005:	48 8b 5a 18          	mov    rbx,QWORD PTR [rdx+0x18]
ffffffff80003009:	48 85 db             	test   rbx,rbx
ffffffff8000300c:	0f 84 92 00 00 00    	je     ffffffff800030a4 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1f4>
ffffffff80003012:	4c 8b 62 10          	mov    r12,QWORD PTR [rdx+0x10]
ffffffff80003016:	4c 8b 2a             	mov    r13,QWORD PTR [rdx]
ffffffff80003019:	48 c1 e3 04          	shl    rbx,0x4
ffffffff8000301d:	31 ed                	xor    ebp,ebp
ffffffff8000301f:	4c 8d 74 24 08       	lea    r14,[rsp+0x8]
ffffffff80003024:	45 31 ff             	xor    r15d,r15d
ffffffff80003027:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
ffffffff8000302e:	00 00 
ffffffff80003030:	49 8b 54 2d 08       	mov    rdx,QWORD PTR [r13+rbp*1+0x8]
ffffffff80003035:	48 85 d2             	test   rdx,rdx
ffffffff80003038:	74 16                	je     ffffffff80003050 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1a0>
ffffffff8000303a:	48 8b 7c 24 28       	mov    rdi,QWORD PTR [rsp+0x28]
ffffffff8000303f:	48 8b 44 24 30       	mov    rax,QWORD PTR [rsp+0x30]
ffffffff80003044:	49 8b 74 2d 00       	mov    rsi,QWORD PTR [r13+rbp*1+0x0]
ffffffff80003049:	ff 50 18             	call   QWORD PTR [rax+0x18]
ffffffff8000304c:	84 c0                	test   al,al
ffffffff8000304e:	75 50                	jne    ffffffff800030a0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1f0>
ffffffff80003050:	49 8b 3c 2c          	mov    rdi,QWORD PTR [r12+rbp*1]
ffffffff80003054:	4c 89 f6             	mov    rsi,r14
ffffffff80003057:	41 ff 54 2c 08       	call   QWORD PTR [r12+rbp*1+0x8]
ffffffff8000305c:	84 c0                	test   al,al
ffffffff8000305e:	75 40                	jne    ffffffff800030a0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1f0>
ffffffff80003060:	48 83 c5 10          	add    rbp,0x10
ffffffff80003064:	49 ff c7             	inc    r15
ffffffff80003067:	48 39 eb             	cmp    rbx,rbp
ffffffff8000306a:	75 c4                	jne    ffffffff80003030 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x180>
ffffffff8000306c:	eb 03                	jmp    ffffffff80003071 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1c1>
ffffffff8000306e:	45 31 ff             	xor    r15d,r15d
ffffffff80003071:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
ffffffff80003075:	4c 3b 78 08          	cmp    r15,QWORD PTR [rax+0x8]
ffffffff80003079:	73 36                	jae    ffffffff800030b1 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x201>
ffffffff8000307b:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
ffffffff8000307f:	48 8b 00             	mov    rax,QWORD PTR [rax]
ffffffff80003082:	49 c1 e7 04          	shl    r15,0x4
ffffffff80003086:	48 8b 7c 24 28       	mov    rdi,QWORD PTR [rsp+0x28]
ffffffff8000308b:	48 8b 4c 24 30       	mov    rcx,QWORD PTR [rsp+0x30]
ffffffff80003090:	4a 8b 34 38          	mov    rsi,QWORD PTR [rax+r15*1]
ffffffff80003094:	4a 8b 54 38 08       	mov    rdx,QWORD PTR [rax+r15*1+0x8]
ffffffff80003099:	ff 51 18             	call   QWORD PTR [rcx+0x18]
ffffffff8000309c:	84 c0                	test   al,al
ffffffff8000309e:	74 11                	je     ffffffff800030b1 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x201>
ffffffff800030a0:	b0 01                	mov    al,0x1
ffffffff800030a2:	eb 0f                	jmp    ffffffff800030b3 <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x203>
ffffffff800030a4:	45 31 ff             	xor    r15d,r15d
ffffffff800030a7:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
ffffffff800030ab:	4c 3b 78 08          	cmp    r15,QWORD PTR [rax+0x8]
ffffffff800030af:	72 ca                	jb     ffffffff8000307b <_ZN4core3fmt5write17h05f6075d8c4feeaaE+0x1cb>
ffffffff800030b1:	31 c0                	xor    eax,eax
ffffffff800030b3:	48 83 c4 48          	add    rsp,0x48
ffffffff800030b7:	5b                   	pop    rbx
ffffffff800030b8:	41 5c                	pop    r12
ffffffff800030ba:	41 5d                	pop    r13
ffffffff800030bc:	41 5e                	pop    r14
ffffffff800030be:	41 5f                	pop    r15
ffffffff800030c0:	5d                   	pop    rbp
ffffffff800030c1:	c3                   	ret    
ffffffff800030c2:	cc                   	int3   
ffffffff800030c3:	cc                   	int3   
ffffffff800030c4:	cc                   	int3   
ffffffff800030c5:	cc                   	int3   
ffffffff800030c6:	cc                   	int3   
ffffffff800030c7:	cc                   	int3   
ffffffff800030c8:	cc                   	int3   
ffffffff800030c9:	cc                   	int3   
ffffffff800030ca:	cc                   	int3   
ffffffff800030cb:	cc                   	int3   
ffffffff800030cc:	cc                   	int3   
ffffffff800030cd:	cc                   	int3   
ffffffff800030ce:	cc                   	int3   
ffffffff800030cf:	cc                   	int3   

ffffffff800030d0 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E>:
ffffffff800030d0:	48 83 ec 28          	sub    rsp,0x28
ffffffff800030d4:	48 89 f0             	mov    rax,rsi
ffffffff800030d7:	8b 17                	mov    edx,DWORD PTR [rdi]
ffffffff800030d9:	be 27 00 00 00       	mov    esi,0x27
ffffffff800030de:	48 8d 0d 95 33 00 00 	lea    rcx,[rip+0x3395]        # ffffffff8000647a <memset+0x2c9a>
ffffffff800030e5:	48 81 fa 10 27 00 00 	cmp    rdx,0x2710
ffffffff800030ec:	0f 82 b4 00 00 00    	jb     ffffffff800031a6 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E+0xd6>
ffffffff800030f2:	41 b9 27 00 00 00    	mov    r9d,0x27
ffffffff800030f8:	49 b8 4b 59 86 38 d6 	movabs r8,0x346dc5d63886594b
ffffffff800030ff:	c5 6d 34 
ffffffff80003102:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff80003109:	1f 84 00 00 00 00 00 
ffffffff80003110:	c4 c2 c3 f6 f8       	mulx   rdi,rdi,r8
ffffffff80003115:	48 c1 ef 0b          	shr    rdi,0xb
ffffffff80003119:	69 f7 10 27 00 00    	imul   esi,edi,0x2710
ffffffff8000311f:	41 89 d2             	mov    r10d,edx
ffffffff80003122:	41 29 f2             	sub    r10d,esi
ffffffff80003125:	45 69 da 7b 14 00 00 	imul   r11d,r10d,0x147b
ffffffff8000312c:	41 c1 eb 13          	shr    r11d,0x13
ffffffff80003130:	41 6b f3 64          	imul   esi,r11d,0x64
ffffffff80003134:	41 29 f2             	sub    r10d,esi
ffffffff80003137:	45 0f b7 d2          	movzx  r10d,r10w
ffffffff8000313b:	49 8d 71 fc          	lea    rsi,[r9-0x4]
ffffffff8000313f:	46 0f b7 1c 59       	movzx  r11d,WORD PTR [rcx+r11*2]
ffffffff80003144:	66 46 89 5c 0c fd    	mov    WORD PTR [rsp+r9*1-0x3],r11w
ffffffff8000314a:	46 0f b7 14 51       	movzx  r10d,WORD PTR [rcx+r10*2]
ffffffff8000314f:	66 46 89 54 0c ff    	mov    WORD PTR [rsp+r9*1-0x1],r10w
ffffffff80003155:	49 89 f1             	mov    r9,rsi
ffffffff80003158:	48 81 fa ff e0 f5 05 	cmp    rdx,0x5f5e0ff
ffffffff8000315f:	48 89 fa             	mov    rdx,rdi
ffffffff80003162:	77 ac                	ja     ffffffff80003110 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E+0x40>
ffffffff80003164:	48 83 ff 63          	cmp    rdi,0x63
ffffffff80003168:	76 29                	jbe    ffffffff80003193 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E+0xc3>
ffffffff8000316a:	0f b7 d7             	movzx  edx,di
ffffffff8000316d:	c1 ea 02             	shr    edx,0x2
ffffffff80003170:	69 d2 7b 14 00 00    	imul   edx,edx,0x147b
ffffffff80003176:	c1 ea 11             	shr    edx,0x11
ffffffff80003179:	44 6b c2 64          	imul   r8d,edx,0x64
ffffffff8000317d:	44 29 c7             	sub    edi,r8d
ffffffff80003180:	0f b7 ff             	movzx  edi,di
ffffffff80003183:	0f b7 3c 79          	movzx  edi,WORD PTR [rcx+rdi*2]
ffffffff80003187:	66 89 7c 34 ff       	mov    WORD PTR [rsp+rsi*1-0x1],di
ffffffff8000318c:	48 83 c6 fe          	add    rsi,0xfffffffffffffffe
ffffffff80003190:	48 89 d7             	mov    rdi,rdx
ffffffff80003193:	48 83 ff 0a          	cmp    rdi,0xa
ffffffff80003197:	73 18                	jae    ffffffff800031b1 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E+0xe1>
ffffffff80003199:	40 80 cf 30          	or     dil,0x30
ffffffff8000319d:	40 88 3c 34          	mov    BYTE PTR [rsp+rsi*1],dil
ffffffff800031a1:	48 ff ce             	dec    rsi
ffffffff800031a4:	eb 18                	jmp    ffffffff800031be <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E+0xee>
ffffffff800031a6:	48 89 d7             	mov    rdi,rdx
ffffffff800031a9:	48 83 ff 63          	cmp    rdi,0x63
ffffffff800031ad:	77 bb                	ja     ffffffff8000316a <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E+0x9a>
ffffffff800031af:	eb e2                	jmp    ffffffff80003193 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf302f7bacbc89810E+0xc3>
ffffffff800031b1:	0f b7 0c 79          	movzx  ecx,WORD PTR [rcx+rdi*2]
ffffffff800031b5:	66 89 4c 34 ff       	mov    WORD PTR [rsp+rsi*1-0x1],cx
ffffffff800031ba:	48 83 c6 fe          	add    rsi,0xfffffffffffffffe
ffffffff800031be:	48 8d 0c 34          	lea    rcx,[rsp+rsi*1]
ffffffff800031c2:	48 ff c1             	inc    rcx
ffffffff800031c5:	41 b8 27 00 00 00    	mov    r8d,0x27
ffffffff800031cb:	49 29 f0             	sub    r8,rsi
ffffffff800031ce:	be 01 00 00 00       	mov    esi,0x1
ffffffff800031d3:	48 89 c7             	mov    rdi,rax
ffffffff800031d6:	31 d2                	xor    edx,edx
ffffffff800031d8:	e8 03 f2 ff ff       	call   ffffffff800023e0 <_ZN4core3fmt9Formatter12pad_integral17h5d5f894135f513b4E>
ffffffff800031dd:	48 83 c4 28          	add    rsp,0x28
ffffffff800031e1:	c3                   	ret    
ffffffff800031e2:	cc                   	int3   
ffffffff800031e3:	cc                   	int3   
ffffffff800031e4:	cc                   	int3   
ffffffff800031e5:	cc                   	int3   
ffffffff800031e6:	cc                   	int3   
ffffffff800031e7:	cc                   	int3   
ffffffff800031e8:	cc                   	int3   
ffffffff800031e9:	cc                   	int3   
ffffffff800031ea:	cc                   	int3   
ffffffff800031eb:	cc                   	int3   
ffffffff800031ec:	cc                   	int3   
ffffffff800031ed:	cc                   	int3   
ffffffff800031ee:	cc                   	int3   
ffffffff800031ef:	cc                   	int3   

ffffffff800031f0 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E>:
ffffffff800031f0:	48 8d 56 07          	lea    rdx,[rsi+0x7]
ffffffff800031f4:	48 83 e2 f8          	and    rdx,0xfffffffffffffff8
ffffffff800031f8:	48 29 f2             	sub    rdx,rsi
ffffffff800031fb:	31 c0                	xor    eax,eax
ffffffff800031fd:	4c 8d 05 72 33 00 00 	lea    r8,[rip+0x3372]        # ffffffff80006576 <memset+0x2d96>
ffffffff80003204:	eb 14                	jmp    ffffffff8000321a <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x2a>
ffffffff80003206:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
ffffffff8000320d:	00 00 00 
ffffffff80003210:	48 83 f8 0c          	cmp    rax,0xc
ffffffff80003214:	0f 83 7a 01 00 00    	jae    ffffffff80003394 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1a4>
ffffffff8000321a:	44 0f b6 0c 06       	movzx  r9d,BYTE PTR [rsi+rax*1]
ffffffff8000321f:	45 84 c9             	test   r9b,r9b
ffffffff80003222:	78 3c                	js     ffffffff80003260 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x70>
ffffffff80003224:	89 d1                	mov    ecx,edx
ffffffff80003226:	29 c1                	sub    ecx,eax
ffffffff80003228:	f6 c1 07             	test   cl,0x7
ffffffff8000322b:	74 20                	je     ffffffff8000324d <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x5d>
ffffffff8000322d:	48 ff c0             	inc    rax
ffffffff80003230:	48 83 f8 0c          	cmp    rax,0xc
ffffffff80003234:	72 e4                	jb     ffffffff8000321a <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x2a>
ffffffff80003236:	e9 59 01 00 00       	jmp    ffffffff80003394 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1a4>
ffffffff8000323b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
ffffffff80003240:	48 ff c0             	inc    rax
ffffffff80003243:	48 83 f8 0c          	cmp    rax,0xc
ffffffff80003247:	0f 84 47 01 00 00    	je     ffffffff80003394 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1a4>
ffffffff8000324d:	80 3c 06 00          	cmp    BYTE PTR [rsi+rax*1],0x0
ffffffff80003251:	79 ed                	jns    ffffffff80003240 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x50>
ffffffff80003253:	eb bb                	jmp    ffffffff80003210 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x20>
ffffffff80003255:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
ffffffff8000325c:	00 00 00 00 
ffffffff80003260:	47 0f b6 14 01       	movzx  r10d,BYTE PTR [r9+r8*1]
ffffffff80003265:	b1 01                	mov    cl,0x1
ffffffff80003267:	41 83 fa 04          	cmp    r10d,0x4
ffffffff8000326b:	74 67                	je     ffffffff800032d4 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0xe4>
ffffffff8000326d:	41 83 fa 03          	cmp    r10d,0x3
ffffffff80003271:	74 34                	je     ffffffff800032a7 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0xb7>
ffffffff80003273:	41 83 fa 02          	cmp    r10d,0x2
ffffffff80003277:	0f 85 29 01 00 00    	jne    ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff8000327d:	48 83 f8 0b          	cmp    rax,0xb
ffffffff80003281:	0f 83 23 01 00 00    	jae    ffffffff800033aa <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1ba>
ffffffff80003287:	80 7c 06 01 bf       	cmp    BYTE PTR [rsi+rax*1+0x1],0xbf
ffffffff8000328c:	0f 8f 14 01 00 00    	jg     ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff80003292:	48 ff c0             	inc    rax
ffffffff80003295:	48 ff c0             	inc    rax
ffffffff80003298:	48 83 f8 0c          	cmp    rax,0xc
ffffffff8000329c:	0f 82 78 ff ff ff    	jb     ffffffff8000321a <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x2a>
ffffffff800032a2:	e9 ed 00 00 00       	jmp    ffffffff80003394 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1a4>
ffffffff800032a7:	48 83 f8 0b          	cmp    rax,0xb
ffffffff800032ab:	0f 83 f9 00 00 00    	jae    ffffffff800033aa <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1ba>
ffffffff800032b1:	44 0f b6 54 30 01    	movzx  r10d,BYTE PTR [rax+rsi*1+0x1]
ffffffff800032b7:	49 81 f9 e0 00 00 00 	cmp    r9,0xe0
ffffffff800032be:	74 41                	je     ffffffff80003301 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x111>
ffffffff800032c0:	41 81 f9 ed 00 00 00 	cmp    r9d,0xed
ffffffff800032c7:	75 56                	jne    ffffffff8000331f <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x12f>
ffffffff800032c9:	41 80 fa 9f          	cmp    r10b,0x9f
ffffffff800032cd:	7e 6a                	jle    ffffffff80003339 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x149>
ffffffff800032cf:	e9 d2 00 00 00       	jmp    ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff800032d4:	48 83 f8 0b          	cmp    rax,0xb
ffffffff800032d8:	0f 83 cc 00 00 00    	jae    ffffffff800033aa <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1ba>
ffffffff800032de:	44 0f b6 54 30 01    	movzx  r10d,BYTE PTR [rax+rsi*1+0x1]
ffffffff800032e4:	49 81 f9 f0 00 00 00 	cmp    r9,0xf0
ffffffff800032eb:	74 23                	je     ffffffff80003310 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x120>
ffffffff800032ed:	41 81 f9 f4 00 00 00 	cmp    r9d,0xf4
ffffffff800032f4:	75 63                	jne    ffffffff80003359 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x169>
ffffffff800032f6:	41 80 fa 8f          	cmp    r10b,0x8f
ffffffff800032fa:	7e 6d                	jle    ffffffff80003369 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x179>
ffffffff800032fc:	e9 a5 00 00 00       	jmp    ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff80003301:	41 80 e2 e0          	and    r10b,0xe0
ffffffff80003305:	41 80 fa a0          	cmp    r10b,0xa0
ffffffff80003309:	74 2e                	je     ffffffff80003339 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x149>
ffffffff8000330b:	e9 96 00 00 00       	jmp    ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff80003310:	41 80 c2 70          	add    r10b,0x70
ffffffff80003314:	41 80 fa 30          	cmp    r10b,0x30
ffffffff80003318:	72 4f                	jb     ffffffff80003369 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x179>
ffffffff8000331a:	e9 87 00 00 00       	jmp    ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff8000331f:	45 8d 59 1f          	lea    r11d,[r9+0x1f]
ffffffff80003323:	41 80 fb 0c          	cmp    r11b,0xc
ffffffff80003327:	72 0a                	jb     ffffffff80003333 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x143>
ffffffff80003329:	41 80 e1 fe          	and    r9b,0xfe
ffffffff8000332d:	41 80 f9 ee          	cmp    r9b,0xee
ffffffff80003331:	75 73                	jne    ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff80003333:	41 80 fa c0          	cmp    r10b,0xc0
ffffffff80003337:	7d 6d                	jge    ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff80003339:	48 83 f8 0a          	cmp    rax,0xa
ffffffff8000333d:	74 6f                	je     ffffffff800033ae <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1be>
ffffffff8000333f:	80 7c 06 02 bf       	cmp    BYTE PTR [rsi+rax*1+0x2],0xbf
ffffffff80003344:	7f 71                	jg     ffffffff800033b7 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1c7>
ffffffff80003346:	48 83 c0 02          	add    rax,0x2
ffffffff8000334a:	48 ff c0             	inc    rax
ffffffff8000334d:	48 83 f8 0c          	cmp    rax,0xc
ffffffff80003351:	0f 82 c3 fe ff ff    	jb     ffffffff8000321a <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x2a>
ffffffff80003357:	eb 3b                	jmp    ffffffff80003394 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1a4>
ffffffff80003359:	41 80 c1 0f          	add    r9b,0xf
ffffffff8000335d:	41 80 f9 02          	cmp    r9b,0x2
ffffffff80003361:	77 43                	ja     ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff80003363:	41 80 fa c0          	cmp    r10b,0xc0
ffffffff80003367:	7d 3d                	jge    ffffffff800033a6 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1b6>
ffffffff80003369:	48 83 f8 0a          	cmp    rax,0xa
ffffffff8000336d:	74 3f                	je     ffffffff800033ae <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1be>
ffffffff8000336f:	80 7c 30 02 bf       	cmp    BYTE PTR [rax+rsi*1+0x2],0xbf
ffffffff80003374:	7f 41                	jg     ffffffff800033b7 <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1c7>
ffffffff80003376:	48 83 f8 08          	cmp    rax,0x8
ffffffff8000337a:	77 2e                	ja     ffffffff800033aa <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1ba>
ffffffff8000337c:	80 7c 06 03 bf       	cmp    BYTE PTR [rsi+rax*1+0x3],0xbf
ffffffff80003381:	7f 38                	jg     ffffffff800033bb <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1cb>
ffffffff80003383:	48 83 c0 03          	add    rax,0x3
ffffffff80003387:	48 ff c0             	inc    rax
ffffffff8000338a:	48 83 f8 0c          	cmp    rax,0xc
ffffffff8000338e:	0f 82 86 fe ff ff    	jb     ffffffff8000321a <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x2a>
ffffffff80003394:	48 89 77 08          	mov    QWORD PTR [rdi+0x8],rsi
ffffffff80003398:	48 c7 47 10 0c 00 00 	mov    QWORD PTR [rdi+0x10],0xc
ffffffff8000339f:	00 
ffffffff800033a0:	31 c0                	xor    eax,eax
ffffffff800033a2:	48 89 07             	mov    QWORD PTR [rdi],rax
ffffffff800033a5:	c3                   	ret    
ffffffff800033a6:	b2 01                	mov    dl,0x1
ffffffff800033a8:	eb 13                	jmp    ffffffff800033bd <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1cd>
ffffffff800033aa:	31 c9                	xor    ecx,ecx
ffffffff800033ac:	eb 0f                	jmp    ffffffff800033bd <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1cd>
ffffffff800033ae:	b8 0a 00 00 00       	mov    eax,0xa
ffffffff800033b3:	31 c9                	xor    ecx,ecx
ffffffff800033b5:	eb 06                	jmp    ffffffff800033bd <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1cd>
ffffffff800033b7:	b2 02                	mov    dl,0x2
ffffffff800033b9:	eb 02                	jmp    ffffffff800033bd <_ZN4core3str8converts9from_utf817hc541cdb684f9a4d4E+0x1cd>
ffffffff800033bb:	b2 03                	mov    dl,0x3
ffffffff800033bd:	48 89 47 08          	mov    QWORD PTR [rdi+0x8],rax
ffffffff800033c1:	88 4f 10             	mov    BYTE PTR [rdi+0x10],cl
ffffffff800033c4:	88 57 11             	mov    BYTE PTR [rdi+0x11],dl
ffffffff800033c7:	b8 01 00 00 00       	mov    eax,0x1
ffffffff800033cc:	48 89 07             	mov    QWORD PTR [rdi],rax
ffffffff800033cf:	c3                   	ret    

ffffffff800033d0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E>:
ffffffff800033d0:	55                   	push   rbp
ffffffff800033d1:	41 57                	push   r15
ffffffff800033d3:	41 56                	push   r14
ffffffff800033d5:	41 55                	push   r13
ffffffff800033d7:	41 54                	push   r12
ffffffff800033d9:	53                   	push   rbx
ffffffff800033da:	48 83 ec 28          	sub    rsp,0x28
ffffffff800033de:	48 89 74 24 08       	mov    QWORD PTR [rsp+0x8],rsi
ffffffff800033e3:	49 bf ff fe fe fe fe 	movabs r15,0xfefefefefefefeff
ffffffff800033ea:	fe fe fe 
ffffffff800033ed:	48 bd 0a 0a 0a 0a 0a 	movabs rbp,0xa0a0a0a0a0a0a0a
ffffffff800033f4:	0a 0a 0a 
ffffffff800033f7:	48 8b 47 10          	mov    rax,QWORD PTR [rdi+0x10]
ffffffff800033fb:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff80003400:	48 8b 07             	mov    rax,QWORD PTR [rdi]
ffffffff80003403:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff80003408:	48 8b 47 08          	mov    rax,QWORD PTR [rdi+0x8]
ffffffff8000340c:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
ffffffff80003411:	45 31 f6             	xor    r14d,r14d
ffffffff80003414:	45 31 e4             	xor    r12d,r12d
ffffffff80003417:	eb 53                	jmp    ffffffff8000346c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x9c>
ffffffff80003419:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
ffffffff80003420:	41 80 7c 2b ff 0a    	cmp    BYTE PTR [r11+rbp*1-0x1],0xa
ffffffff80003426:	0f 94 c0             	sete   al
ffffffff80003429:	4c 29 e5             	sub    rbp,r12
ffffffff8000342c:	4d 01 dc             	add    r12,r11
ffffffff8000342f:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
ffffffff80003434:	88 01                	mov    BYTE PTR [rcx],al
ffffffff80003436:	48 8b 7c 24 18       	mov    rdi,QWORD PTR [rsp+0x18]
ffffffff8000343b:	4c 89 e6             	mov    rsi,r12
ffffffff8000343e:	48 89 ea             	mov    rdx,rbp
ffffffff80003441:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
ffffffff80003446:	ff 50 18             	call   QWORD PTR [rax+0x18]
ffffffff80003449:	41 08 c7             	or     r15b,al
ffffffff8000344c:	4d 89 ec             	mov    r12,r13
ffffffff8000344f:	49 bf ff fe fe fe fe 	movabs r15,0xfefefefefefefeff
ffffffff80003456:	fe fe fe 
ffffffff80003459:	48 89 da             	mov    rdx,rbx
ffffffff8000345c:	48 bd 0a 0a 0a 0a 0a 	movabs rbp,0xa0a0a0a0a0a0a0a
ffffffff80003463:	0a 0a 0a 
ffffffff80003466:	0f 85 ad 01 00 00    	jne    ffffffff80003619 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x249>
ffffffff8000346c:	49 39 d6             	cmp    r14,rdx
ffffffff8000346f:	76 0f                	jbe    ffffffff80003480 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0xb0>
ffffffff80003471:	4d 89 f5             	mov    r13,r14
ffffffff80003474:	4c 8b 5c 24 08       	mov    r11,QWORD PTR [rsp+0x8]
ffffffff80003479:	e9 45 01 00 00       	jmp    ffffffff800035c3 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1f3>
ffffffff8000347e:	66 90                	xchg   ax,ax
ffffffff80003480:	4c 8b 5c 24 08       	mov    r11,QWORD PTR [rsp+0x8]
ffffffff80003485:	eb 15                	jmp    ffffffff8000349c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0xcc>
ffffffff80003487:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
ffffffff8000348e:	00 00 
ffffffff80003490:	4d 89 ee             	mov    r14,r13
ffffffff80003493:	49 39 d5             	cmp    r13,rdx
ffffffff80003496:	0f 87 27 01 00 00    	ja     ffffffff800035c3 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1f3>
ffffffff8000349c:	48 89 d1             	mov    rcx,rdx
ffffffff8000349f:	4c 29 f1             	sub    rcx,r14
ffffffff800034a2:	4b 8d 04 33          	lea    rax,[r11+r14*1]
ffffffff800034a6:	48 83 f9 0f          	cmp    rcx,0xf
ffffffff800034aa:	77 34                	ja     ffffffff800034e0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x110>
ffffffff800034ac:	4c 39 f2             	cmp    rdx,r14
ffffffff800034af:	0f 84 0b 01 00 00    	je     ffffffff800035c0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1f0>
ffffffff800034b5:	31 ff                	xor    edi,edi
ffffffff800034b7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
ffffffff800034be:	00 00 
ffffffff800034c0:	80 3c 38 0a          	cmp    BYTE PTR [rax+rdi*1],0xa
ffffffff800034c4:	0f 84 c9 00 00 00    	je     ffffffff80003593 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1c3>
ffffffff800034ca:	48 ff c7             	inc    rdi
ffffffff800034cd:	48 39 f9             	cmp    rcx,rdi
ffffffff800034d0:	75 ee                	jne    ffffffff800034c0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0xf0>
ffffffff800034d2:	e9 e9 00 00 00       	jmp    ffffffff800035c0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1f0>
ffffffff800034d7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
ffffffff800034de:	00 00 
ffffffff800034e0:	48 8d 70 07          	lea    rsi,[rax+0x7]
ffffffff800034e4:	48 83 e6 f8          	and    rsi,0xfffffffffffffff8
ffffffff800034e8:	48 89 f3             	mov    rbx,rsi
ffffffff800034eb:	48 29 c3             	sub    rbx,rax
ffffffff800034ee:	49 bd 80 80 80 80 80 	movabs r13,0x8080808080808080
ffffffff800034f5:	80 80 80 
ffffffff800034f8:	74 23                	je     ffffffff8000351d <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x14d>
ffffffff800034fa:	31 ff                	xor    edi,edi
ffffffff800034fc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
ffffffff80003500:	80 3c 38 0a          	cmp    BYTE PTR [rax+rdi*1],0xa
ffffffff80003504:	0f 84 89 00 00 00    	je     ffffffff80003593 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1c3>
ffffffff8000350a:	48 ff c7             	inc    rdi
ffffffff8000350d:	48 39 fb             	cmp    rbx,rdi
ffffffff80003510:	75 ee                	jne    ffffffff80003500 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x130>
ffffffff80003512:	48 8d 79 f0          	lea    rdi,[rcx-0x10]
ffffffff80003516:	48 39 fb             	cmp    rbx,rdi
ffffffff80003519:	76 06                	jbe    ffffffff80003521 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x151>
ffffffff8000351b:	eb 4b                	jmp    ffffffff80003568 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x198>
ffffffff8000351d:	48 8d 79 f0          	lea    rdi,[rcx-0x10]
ffffffff80003521:	41 b8 08 00 00 00    	mov    r8d,0x8
ffffffff80003527:	4c 01 c6             	add    rsi,r8
ffffffff8000352a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
ffffffff80003530:	4c 8b 46 f8          	mov    r8,QWORD PTR [rsi-0x8]
ffffffff80003534:	4c 8b 0e             	mov    r9,QWORD PTR [rsi]
ffffffff80003537:	4d 89 c2             	mov    r10,r8
ffffffff8000353a:	49 31 ea             	xor    r10,rbp
ffffffff8000353d:	4d 01 fa             	add    r10,r15
ffffffff80003540:	c4 42 b8 f2 c2       	andn   r8,r8,r10
ffffffff80003545:	4d 89 ca             	mov    r10,r9
ffffffff80003548:	49 31 ea             	xor    r10,rbp
ffffffff8000354b:	4d 01 fa             	add    r10,r15
ffffffff8000354e:	c4 42 b0 f2 ca       	andn   r9,r9,r10
ffffffff80003553:	4d 09 c1             	or     r9,r8
ffffffff80003556:	4d 85 e9             	test   r9,r13
ffffffff80003559:	75 0d                	jne    ffffffff80003568 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x198>
ffffffff8000355b:	48 83 c3 10          	add    rbx,0x10
ffffffff8000355f:	48 83 c6 10          	add    rsi,0x10
ffffffff80003563:	48 39 fb             	cmp    rbx,rdi
ffffffff80003566:	76 c8                	jbe    ffffffff80003530 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x160>
ffffffff80003568:	48 39 cb             	cmp    rbx,rcx
ffffffff8000356b:	74 53                	je     ffffffff800035c0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1f0>
ffffffff8000356d:	48 8d 0c 18          	lea    rcx,[rax+rbx*1]
ffffffff80003571:	48 89 d6             	mov    rsi,rdx
ffffffff80003574:	48 29 de             	sub    rsi,rbx
ffffffff80003577:	4c 29 f6             	sub    rsi,r14
ffffffff8000357a:	31 ff                	xor    edi,edi
ffffffff8000357c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
ffffffff80003580:	80 3c 39 0a          	cmp    BYTE PTR [rcx+rdi*1],0xa
ffffffff80003584:	74 0a                	je     ffffffff80003590 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1c0>
ffffffff80003586:	48 ff c7             	inc    rdi
ffffffff80003589:	48 39 fe             	cmp    rsi,rdi
ffffffff8000358c:	75 f2                	jne    ffffffff80003580 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1b0>
ffffffff8000358e:	eb 30                	jmp    ffffffff800035c0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x1f0>
ffffffff80003590:	48 01 df             	add    rdi,rbx
ffffffff80003593:	4d 8d 2c 3e          	lea    r13,[r14+rdi*1]
ffffffff80003597:	49 ff c5             	inc    r13
ffffffff8000359a:	49 01 fe             	add    r14,rdi
ffffffff8000359d:	49 39 d6             	cmp    r14,rdx
ffffffff800035a0:	0f 83 ea fe ff ff    	jae    ffffffff80003490 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0xc0>
ffffffff800035a6:	80 3c 38 0a          	cmp    BYTE PTR [rax+rdi*1],0xa
ffffffff800035aa:	0f 85 e0 fe ff ff    	jne    ffffffff80003490 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0xc0>
ffffffff800035b0:	48 89 d3             	mov    rbx,rdx
ffffffff800035b3:	45 31 ff             	xor    r15d,r15d
ffffffff800035b6:	4d 89 ee             	mov    r14,r13
ffffffff800035b9:	4c 89 ed             	mov    rbp,r13
ffffffff800035bc:	eb 19                	jmp    ffffffff800035d7 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x207>
ffffffff800035be:	66 90                	xchg   ax,ax
ffffffff800035c0:	49 89 d5             	mov    r13,rdx
ffffffff800035c3:	41 b7 01             	mov    r15b,0x1
ffffffff800035c6:	4d 89 ee             	mov    r14,r13
ffffffff800035c9:	4d 89 e5             	mov    r13,r12
ffffffff800035cc:	48 89 d5             	mov    rbp,rdx
ffffffff800035cf:	48 89 d3             	mov    rbx,rdx
ffffffff800035d2:	49 39 d4             	cmp    r12,rdx
ffffffff800035d5:	74 3c                	je     ffffffff80003613 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x243>
ffffffff800035d7:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
ffffffff800035dc:	80 38 00             	cmp    BYTE PTR [rax],0x0
ffffffff800035df:	74 22                	je     ffffffff80003603 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x233>
ffffffff800035e1:	ba 04 00 00 00       	mov    edx,0x4
ffffffff800035e6:	48 8b 7c 24 18       	mov    rdi,QWORD PTR [rsp+0x18]
ffffffff800035eb:	48 8d 35 22 12 00 00 	lea    rsi,[rip+0x1222]        # ffffffff80004814 <memset+0x1034>
ffffffff800035f2:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
ffffffff800035f7:	ff 50 18             	call   QWORD PTR [rax+0x18]
ffffffff800035fa:	4c 8b 5c 24 08       	mov    r11,QWORD PTR [rsp+0x8]
ffffffff800035ff:	84 c0                	test   al,al
ffffffff80003601:	75 14                	jne    ffffffff80003617 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x247>
ffffffff80003603:	4c 39 e5             	cmp    rbp,r12
ffffffff80003606:	0f 85 14 fe ff ff    	jne    ffffffff80003420 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x50>
ffffffff8000360c:	31 c0                	xor    eax,eax
ffffffff8000360e:	e9 16 fe ff ff       	jmp    ffffffff80003429 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x59>
ffffffff80003613:	31 c0                	xor    eax,eax
ffffffff80003615:	eb 02                	jmp    ffffffff80003619 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E+0x249>
ffffffff80003617:	b0 01                	mov    al,0x1
ffffffff80003619:	48 83 c4 28          	add    rsp,0x28
ffffffff8000361d:	5b                   	pop    rbx
ffffffff8000361e:	41 5c                	pop    r12
ffffffff80003620:	41 5d                	pop    r13
ffffffff80003622:	41 5e                	pop    r14
ffffffff80003624:	41 5f                	pop    r15
ffffffff80003626:	5d                   	pop    rbp
ffffffff80003627:	c3                   	ret    
ffffffff80003628:	cc                   	int3   
ffffffff80003629:	cc                   	int3   
ffffffff8000362a:	cc                   	int3   
ffffffff8000362b:	cc                   	int3   
ffffffff8000362c:	cc                   	int3   
ffffffff8000362d:	cc                   	int3   
ffffffff8000362e:	cc                   	int3   
ffffffff8000362f:	cc                   	int3   

ffffffff80003630 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$10write_char17h3b89d3424ec70972E>:
ffffffff80003630:	55                   	push   rbp
ffffffff80003631:	41 57                	push   r15
ffffffff80003633:	41 56                	push   r14
ffffffff80003635:	53                   	push   rbx
ffffffff80003636:	50                   	push   rax
ffffffff80003637:	4c 8b 77 10          	mov    r14,QWORD PTR [rdi+0x10]
ffffffff8000363b:	41 80 3e 00          	cmp    BYTE PTR [r14],0x0
ffffffff8000363f:	48 8b 1f             	mov    rbx,QWORD PTR [rdi]
ffffffff80003642:	4c 8b 7f 08          	mov    r15,QWORD PTR [rdi+0x8]
ffffffff80003646:	74 2b                	je     ffffffff80003673 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$10write_char17h3b89d3424ec70972E+0x43>
ffffffff80003648:	48 8d 05 c5 11 00 00 	lea    rax,[rip+0x11c5]        # ffffffff80004814 <memset+0x1034>
ffffffff8000364f:	ba 04 00 00 00       	mov    edx,0x4
ffffffff80003654:	48 89 df             	mov    rdi,rbx
ffffffff80003657:	89 f5                	mov    ebp,esi
ffffffff80003659:	48 89 c6             	mov    rsi,rax
ffffffff8000365c:	41 ff 57 18          	call   QWORD PTR [r15+0x18]
ffffffff80003660:	89 ee                	mov    esi,ebp
ffffffff80003662:	84 c0                	test   al,al
ffffffff80003664:	74 0d                	je     ffffffff80003673 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$10write_char17h3b89d3424ec70972E+0x43>
ffffffff80003666:	b0 01                	mov    al,0x1
ffffffff80003668:	48 83 c4 08          	add    rsp,0x8
ffffffff8000366c:	5b                   	pop    rbx
ffffffff8000366d:	41 5e                	pop    r14
ffffffff8000366f:	41 5f                	pop    r15
ffffffff80003671:	5d                   	pop    rbp
ffffffff80003672:	c3                   	ret    
ffffffff80003673:	83 fe 0a             	cmp    esi,0xa
ffffffff80003676:	41 0f 94 06          	sete   BYTE PTR [r14]
ffffffff8000367a:	49 8b 47 20          	mov    rax,QWORD PTR [r15+0x20]
ffffffff8000367e:	48 89 df             	mov    rdi,rbx
ffffffff80003681:	48 83 c4 08          	add    rsp,0x8
ffffffff80003685:	5b                   	pop    rbx
ffffffff80003686:	41 5e                	pop    r14
ffffffff80003688:	41 5f                	pop    r15
ffffffff8000368a:	5d                   	pop    rbp
ffffffff8000368b:	ff e0                	jmp    rax
ffffffff8000368d:	cc                   	int3   
ffffffff8000368e:	cc                   	int3   
ffffffff8000368f:	cc                   	int3   

ffffffff80003690 <_ZN4core3fmt5Write9write_fmt17h3b11d29525e730a8E>:
ffffffff80003690:	48 89 f2             	mov    rdx,rsi
ffffffff80003693:	48 8b 4e 08          	mov    rcx,QWORD PTR [rsi+0x8]
ffffffff80003697:	48 8b 46 18          	mov    rax,QWORD PTR [rsi+0x18]
ffffffff8000369b:	48 83 f9 01          	cmp    rcx,0x1
ffffffff8000369f:	74 16                	je     ffffffff800036b7 <_ZN4core3fmt5Write9write_fmt17h3b11d29525e730a8E+0x27>
ffffffff800036a1:	48 85 c9             	test   rcx,rcx
ffffffff800036a4:	75 16                	jne    ffffffff800036bc <_ZN4core3fmt5Write9write_fmt17h3b11d29525e730a8E+0x2c>
ffffffff800036a6:	48 85 c0             	test   rax,rax
ffffffff800036a9:	75 11                	jne    ffffffff800036bc <_ZN4core3fmt5Write9write_fmt17h3b11d29525e730a8E+0x2c>
ffffffff800036ab:	be 01 00 00 00       	mov    esi,0x1
ffffffff800036b0:	31 d2                	xor    edx,edx
ffffffff800036b2:	e9 19 fd ff ff       	jmp    ffffffff800033d0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E>
ffffffff800036b7:	48 85 c0             	test   rax,rax
ffffffff800036ba:	74 0c                	je     ffffffff800036c8 <_ZN4core3fmt5Write9write_fmt17h3b11d29525e730a8E+0x38>
ffffffff800036bc:	48 8d 35 1d 2b 01 00 	lea    rsi,[rip+0x12b1d]        # ffffffff800161e0 <_ZN6kernel15MEM_MAP_REQUEST17h732ade3526e5d81cE+0x100>
ffffffff800036c3:	e9 e8 f7 ff ff       	jmp    ffffffff80002eb0 <_ZN4core3fmt5write17h05f6075d8c4feeaaE>
ffffffff800036c8:	48 8b 02             	mov    rax,QWORD PTR [rdx]
ffffffff800036cb:	48 8b 30             	mov    rsi,QWORD PTR [rax]
ffffffff800036ce:	48 8b 50 08          	mov    rdx,QWORD PTR [rax+0x8]
ffffffff800036d2:	e9 f9 fc ff ff       	jmp    ffffffff800033d0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h8a9e8c87c154cff2E>
ffffffff800036d7:	cc                   	int3   
ffffffff800036d8:	cc                   	int3   
ffffffff800036d9:	cc                   	int3   
ffffffff800036da:	cc                   	int3   
ffffffff800036db:	cc                   	int3   
ffffffff800036dc:	cc                   	int3   
ffffffff800036dd:	cc                   	int3   
ffffffff800036de:	cc                   	int3   
ffffffff800036df:	cc                   	int3   

ffffffff800036e0 <_ZN4core6option13expect_failed17hd9879ea489f48b8fE>:
ffffffff800036e0:	48 83 ec 58          	sub    rsp,0x58
ffffffff800036e4:	48 89 7c 24 08       	mov    QWORD PTR [rsp+0x8],rdi
ffffffff800036e9:	48 89 74 24 10       	mov    QWORD PTR [rsp+0x10],rsi
ffffffff800036ee:	48 8d 44 24 08       	lea    rax,[rsp+0x8]
ffffffff800036f3:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
ffffffff800036f8:	48 8d 05 91 f7 ff ff 	lea    rax,[rip+0xfffffffffffff791]        # ffffffff80002e90 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h5edd5340cb38599eE>
ffffffff800036ff:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
ffffffff80003704:	48 8d 05 d5 2c 00 00 	lea    rax,[rip+0x2cd5]        # ffffffff800063e0 <memset+0x2c00>
ffffffff8000370b:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
ffffffff80003710:	48 c7 44 24 30 01 00 	mov    QWORD PTR [rsp+0x30],0x1
ffffffff80003717:	00 00 
ffffffff80003719:	48 c7 44 24 48 00 00 	mov    QWORD PTR [rsp+0x48],0x0
ffffffff80003720:	00 00 
ffffffff80003722:	48 8d 44 24 18       	lea    rax,[rsp+0x18]
ffffffff80003727:	48 89 44 24 38       	mov    QWORD PTR [rsp+0x38],rax
ffffffff8000372c:	48 c7 44 24 40 01 00 	mov    QWORD PTR [rsp+0x40],0x1
ffffffff80003733:	00 00 
ffffffff80003735:	48 8d 7c 24 28       	lea    rdi,[rsp+0x28]
ffffffff8000373a:	48 89 d6             	mov    rsi,rdx
ffffffff8000373d:	e8 2e ea ff ff       	call   ffffffff80002170 <_ZN4core9panicking9panic_fmt17h1b093805ff9c1e37E>
ffffffff80003742:	cc                   	int3   
ffffffff80003743:	cc                   	int3   
ffffffff80003744:	cc                   	int3   
ffffffff80003745:	cc                   	int3   
ffffffff80003746:	cc                   	int3   
ffffffff80003747:	cc                   	int3   
ffffffff80003748:	cc                   	int3   
ffffffff80003749:	cc                   	int3   
ffffffff8000374a:	cc                   	int3   
ffffffff8000374b:	cc                   	int3   
ffffffff8000374c:	cc                   	int3   
ffffffff8000374d:	cc                   	int3   
ffffffff8000374e:	cc                   	int3   
ffffffff8000374f:	cc                   	int3   

ffffffff80003750 <_ZN17compiler_builtins3mem6memcpy17hdddd65e51ff07f83E>:
ffffffff80003750:	48 89 f8             	mov    rax,rdi
ffffffff80003753:	41 89 c0             	mov    r8d,eax
ffffffff80003756:	41 f7 d8             	neg    r8d
ffffffff80003759:	41 83 e0 07          	and    r8d,0x7
ffffffff8000375d:	49 39 d0             	cmp    r8,rdx
ffffffff80003760:	4c 0f 43 c2          	cmovae r8,rdx
ffffffff80003764:	4c 89 c1             	mov    rcx,r8
ffffffff80003767:	f3 a4                	rep movs BYTE PTR es:[rdi],BYTE PTR ds:[rsi]
ffffffff80003769:	4c 29 c2             	sub    rdx,r8
ffffffff8000376c:	48 89 d1             	mov    rcx,rdx
ffffffff8000376f:	48 c1 e9 03          	shr    rcx,0x3
ffffffff80003773:	f3 48 a5             	rep movs QWORD PTR es:[rdi],QWORD PTR ds:[rsi]
ffffffff80003776:	83 e2 07             	and    edx,0x7
ffffffff80003779:	48 89 d1             	mov    rcx,rdx
ffffffff8000377c:	f3 a4                	rep movs BYTE PTR es:[rdi],BYTE PTR ds:[rsi]
ffffffff8000377e:	c3                   	ret    
ffffffff8000377f:	cc                   	int3   

ffffffff80003780 <memcpy>:
ffffffff80003780:	e9 cb ff ff ff       	jmp    ffffffff80003750 <_ZN17compiler_builtins3mem6memcpy17hdddd65e51ff07f83E>
ffffffff80003785:	cc                   	int3   
ffffffff80003786:	cc                   	int3   
ffffffff80003787:	cc                   	int3   
ffffffff80003788:	cc                   	int3   
ffffffff80003789:	cc                   	int3   
ffffffff8000378a:	cc                   	int3   
ffffffff8000378b:	cc                   	int3   
ffffffff8000378c:	cc                   	int3   
ffffffff8000378d:	cc                   	int3   
ffffffff8000378e:	cc                   	int3   
ffffffff8000378f:	cc                   	int3   

ffffffff80003790 <_ZN17compiler_builtins3mem6memset17hc64bda4bf6517d39E>:
ffffffff80003790:	49 89 d0             	mov    r8,rdx
ffffffff80003793:	48 89 fa             	mov    rdx,rdi
ffffffff80003796:	40 0f b6 ce          	movzx  ecx,sil
ffffffff8000379a:	48 b8 01 01 01 01 01 	movabs rax,0x101010101010101
ffffffff800037a1:	01 01 01 
ffffffff800037a4:	48 0f af c1          	imul   rax,rcx
ffffffff800037a8:	89 d1                	mov    ecx,edx
ffffffff800037aa:	f7 d9                	neg    ecx
ffffffff800037ac:	83 e1 07             	and    ecx,0x7
ffffffff800037af:	4c 39 c1             	cmp    rcx,r8
ffffffff800037b2:	49 0f 43 c8          	cmovae rcx,r8
ffffffff800037b6:	49 29 c8             	sub    r8,rcx
ffffffff800037b9:	4c 89 c6             	mov    rsi,r8
ffffffff800037bc:	48 c1 ee 03          	shr    rsi,0x3
ffffffff800037c0:	41 83 e0 07          	and    r8d,0x7
ffffffff800037c4:	f3 aa                	rep stos BYTE PTR es:[rdi],al
ffffffff800037c6:	48 89 f1             	mov    rcx,rsi
ffffffff800037c9:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
ffffffff800037cc:	4c 89 c1             	mov    rcx,r8
ffffffff800037cf:	f3 aa                	rep stos BYTE PTR es:[rdi],al
ffffffff800037d1:	48 89 d0             	mov    rax,rdx
ffffffff800037d4:	c3                   	ret    
ffffffff800037d5:	cc                   	int3   
ffffffff800037d6:	cc                   	int3   
ffffffff800037d7:	cc                   	int3   
ffffffff800037d8:	cc                   	int3   
ffffffff800037d9:	cc                   	int3   
ffffffff800037da:	cc                   	int3   
ffffffff800037db:	cc                   	int3   
ffffffff800037dc:	cc                   	int3   
ffffffff800037dd:	cc                   	int3   
ffffffff800037de:	cc                   	int3   
ffffffff800037df:	cc                   	int3   

ffffffff800037e0 <memset>:
ffffffff800037e0:	e9 ab ff ff ff       	jmp    ffffffff80003790 <_ZN17compiler_builtins3mem6memset17hc64bda4bf6517d39E>
