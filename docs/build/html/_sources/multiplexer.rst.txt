.. _multiplexer:

Multiplexer
===========

All project design I/O is routed through the Project Multiplexer. It makes sure that only the selected design has its output routed to the I/O pins.
The Multiplexer can be talked to by the management controller over its wishbone interface. This is how the active project selection is changed, as well as other properties of the Multiplexer configured.

I/O Routing and design selection
--------------------------------

Every design has access to up to 36 bi-directional I/O lines, mapped to ``mprj_io[37:4]``, ``mprj_io[2:1]``. To accomplish this, the pad io_in, io_out and io_oeb are routed to designs as follows:

* All designs can directly read from ``{io_in[37:4], io_in[2:1]}``
* Two sets of wires, ``io_out[35:0]`` and ``io_oeb[35:0]`` leave each design and are routed into the Multiplexer
* As the name implies, the Multiplexer only passes one set of io outs and output enables to the chip pads

Additionally, ``mprj_io[0]`` is used as a dedicated reset line for the current design. The reset is a separate input into each design, thus allowing the Multiplexer to hold all non-selected designs in reset.

Custom Settings Register
------------------------

A 32-bit wide register named simply "custom_settings" is also accessible via wishbone. Its contents are readable by all designs on-die, and allow additional settings be set on the selected design without the need to use IO pins for this purpose.

Wishbone address map
--------------------
========== ================= ==========================
Address    Designation       Meaning
========== ================= ==========================
0x30100004 reg_mprj_proj_sel Project selection register
0x30100008 reg_mprj_counter  Timer for debugging
0x3010000C reg_mprj_settings Custom Settings Register
========== ================= ==========================

**Note:** for implementation convenience, these locations must be accessed as 32-bit words, no matter the actual width of the register.

Design address map
------------------

======= ======================================
Address Name
======= ======================================
0       All outputs high-impedance / fgcaptest
1       Z80
2       ScrapCPU
3       VLIW
4       MOS6502
5       AS1802
6       S8x305
7       All outputs high-impedance
======= ======================================

The default state after power-up is design address == 0, with all design IO in high-impedance. This is to not potentially damage any project-specific hardware connected to the chip pins through wrong signals from a different design, no matter how brief.

Project Selection Register
--------------------------

The project selection register contains some additional options besides project selection. It is layed out as such:

.. wavedrom::

    { "reg": [
        {"name": "OE", "bits": 1},
        {"name": "RST", "bits": 1},
        {"name": "SELECT", "bits": 3},
        {"type": 1, "bits": 27}],
    "config": {"hspace": 700}
    }

OE is the "Override Enable". When set, some internal signals can be overriden through the wishbone bus. Currently, this only consists of "RST" which, when "OE" is set, forces the selected design in or out of reset, no matter the state of ``mprj_io[0]``. It is active high.
