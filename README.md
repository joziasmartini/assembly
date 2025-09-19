<div align="center">
  <h1>RISC-V Assembly</h1>
  <p>Studies and algorithms in RISC-V Assembly Language.<p>
</div>

## Assembly

Assembly language is a fundamental component of the computer science field, playing a crucial role in understanding and working with computer systems at a low-level. As one of the oldest and most foundational programming languages, assembly provides a direct and intimate connection between software and hardware.

Assembly language serves as a bridge between high-level programming languages and the machine code that computers understand. It is often referred to as a "low-level" language due to its close correspondence to the architecture and instruction set of a specific computer's processor. Unlike high-level languages such as Python or Java, which are designed to be human-readable and portable, assembly language operates at a level where instructions closely map to the physical operations performed by the computer's hardware.

One of the primary advantages of working with assembly is its ability to provide programmers with fine-grained control over the hardware. By writing code directly in assembly, developers can optimize their programs for performance and efficiency, exploiting the specific features and capabilities of the underlying processor. This level of control is particularly important in areas such as embedded systems, device drivers, operating system development, and real-time applications where every cycle and resource must be carefully managed.

## RISC-V

The RISC-V (pronounced "risk-five") instruction set architecture (ISA) is an open and free architecture designed to provide a standardized framework for computer processors. It stands out as a revolutionary development in the field of computer science, offering numerous advantages and implications for hardware and software designers, researchers, and enthusiasts worldwide.

At its core, RISC-V is a Reduced Instruction Set Computer (RISC) architecture. RISC architectures prioritize simplicity and efficiency by using a small set of instructions that operate on fixed-size data. RISC-V builds upon this foundation, offering a modular and extensible design that supports a wide range of applications, from small embedded systems to large-scale supercomputers. Its instruction set is designed to be clean, orthogonal, and easily expandable, making it suitable for a variety of use cases.

One of the defining characteristics of RISC-V is its open and free nature. Unlike many proprietary ISAs, RISC-V is not controlled by any single organization or entity. It was developed by a collaborative effort from academia and industry, ensuring transparency, inclusiveness, and innovation. The RISC-V Foundation, a non-profit organization, oversees the ongoing development and maintenance of the RISC-V specifications, ensuring that it remains open and accessible to all.

## RARS

RARS (RISC-V Assembler and Runtime Simulator) is a software tool that provides a comprehensive development and learning environment for the RISC-V assembly language. It includes an assembler, a runtime simulator, and a graphical user interface (GUI). RARS allows users to write, assemble, execute, and debug RISC-V assembly code, providing an accessible platform for learning and experimentation.

The assembler component of RARS translates human-readable RISC-V assembly code into machine code. The runtime simulator enables step-by-step execution of RISC-V programs, helping users understand how instructions affect the processor's state. The GUI enhances the user experience by providing features such as source code editing, breakpoints, and register/memory views.

RARS is a valuable resource for students, programmers, and researchers. It offers a controlled environment for newcomers to practice RISC-V assembly programming and serves as an educational tool for teaching computer architecture. It also encourages exploration and experimentation with advanced RISC-V features. Overall, RARS simplifies the development and understanding of RISC-V assembly language, fostering learning, and promoting innovation in the RISC-V ecosystem.

## Who is using RISC-V Assembly?

SiFive: SiFive is a leading provider of RISC-V processor cores, development boards, and related software tools. They offer customizable RISC-V IP solutions for various applications, ranging from microcontrollers to high-performance computing.

NVIDIA: NVIDIA, a prominent technology company known for its graphics processing units (GPUs), has integrated RISC-V cores into some of its products. They have utilized RISC-V for tasks such as security, system management, and control functions.

Western Digital: Western Digital, a storage solutions provider, has embraced RISC-V for its advanced storage platforms. They have developed RISC-V-based processors for specific storage applications, focusing on enhancing performance and efficiency.

Google: Google has shown interest in RISC-V for various projects. They have explored using RISC-V cores in their data centers for certain workload acceleration and have also been involved in research initiatives related to RISC-V.

Alibaba: Alibaba, the Chinese multinational conglomerate, has been actively involved in RISC-V development. They have created their own RISC-V processor designs and are using them for specific applications and platforms.

Huawei: Huawei, a leading technology company, has also embraced RISC-V in its product portfolio. They have been exploring the integration of RISC-V cores in their chips to enhance performance, power efficiency, and security.

Microchip Technology: Microchip Technology, a provider of microcontroller and mixed-signal solutions, has introduced RISC-V-based microcontrollers. These microcontrollers aim to offer flexibility and extensibility while providing a cost-effective solution for embedded applications.

Esperanto Technologies: Esperanto Technologies is a startup focused on developing high-performance, energy-efficient computing solutions based on the RISC-V architecture. They aim to deliver specialized AI and machine learning processors.

Andes Technology: Andes Technology is a company that specializes in RISC-V processor IP cores. They provide a range of customizable cores targeting different performance levels and application domains.

Embecosm: Embecosm is a company offering RISC-V consulting services and development tools. They focus on providing software and compiler toolchain development, enabling efficient utilization of RISC-V processors.

## Files

A description about the files in this repository.

### /src

#### even-number.asm

Checks and returns the occurrence of even numbers in a vector.

#### highest-value.asm

Finds the highest value present in memory.

#### linked-list.asm

A linked list with menu for insertion, removal and listing.

#### multiplication.asm

Implementation of multiplication using successive sums.

#### minefield.asm

A complete implementation of the minefield game.

#### stack-calc.asm

A calculus made in a stack architecture assembly.

#### complete-calc.asm

A complete calculus made as a example in assembly.

#### vector.asm

Print an integer vector.

#### triangle.asm

Check if the given numbers forms a trangle.

#### palindrome.asm

Check if the given string is a palindrome.

#### ordering.asm

Order a integer vector.

#### consonants.asm

Print only the consonants of a given string.

### doc/

#### risc-v-reference-card.pdf

The reference card for instructions in RISC-V architecture.

#### rv32im-isa.pdf

The Instruction Set Architecture (ISA) for RV32IM.
