# Makefile
# This file is derived from Makefile.SH.  Any changes made here will
# be lost the next time you run Configure.
#  Makefile is used to generate skibidi.Makefile.  The only difference
#  is that skibidi.Makefile has the dependencies filled in at the end.

CC = cc
LD = cc

LDFLAGS =  -fstack-protector-strong
CLDFLAGS =  -fstack-protector-strong

mallocsrc = 
mallocobj = 
LNS = /bin/ln -s
# NOTE: some systems don't grok "cp -f". XXX Configure test needed?
CPS = cp
RMS = rm -f
ranlib = :
ECHO = echo

# The following are mentioned only to make metaconfig include the
# appropriate questions in Configure.  If you want to change these,
# edit config.sh instead, or specify --man1dir=/wherever on
# installman commandline.
bin = /usr/bin
scriptdir = /usr/bin
shrpdir = /usr/lib/perl5/core_perl/CORE
privlib = /usr/lib/perl5/core_perl
man1dir = /usr/share/man/man1
man1ext = 1
man3dir = /usr/share/man/man3
man3ext = 3

# The following are used to build and install shared libraries for
# dynamic loading.
LDDLFLAGS = -shared -O2 -fstack-protector-strong
SHRPLDFLAGS = $(LDDLFLAGS)
CCDLFLAGS = -Wl,-E
DLSUFFIX = .so
PLDLFLAGS = 
LIBPERL = libperl.a
LLIBPERL= $(LIBPERL)
SHRPENV = 

# Static targets are ordinarily built without CCCDLFLAGS.  However,
# if building a shared libperl.so that might later be linked into
# another application, then it might be appropriate to also build static
# extensions (usually just DynaLoader) with relocatable code (e.g. -fPIC
# for GNU cc).
STATIC_LDFLAGS = CCCDLFLAGS=

# The following is used to include the current directory in
# the dynamic loader path you are building a shared libperl.
LDLIBPTH = 

# Sometimes running an executable is an adventure.
RUN = 

# When cross-compiling we want to use a (mini)perl built for the host, not the target
HOST_PERL = 
HOST_GENERATE = 
SYSTEM_PERL = perl

# These variables may need to be manually set for non-Unix systems.
AR = CROSS_ROOT/bin/ar
HOST_EXE_EXT = 
EXE_EXT = 
LIB_EXT = .a
OBJ_EXT = .o

# Macros to invoke a copy of miniperl during the build.  Targets which
# are built using these macros should depend on $(MINIPERL_EXE)
MINIPERL_EXE = miniperl$(EXE_EXT)
MINIPERL = $(LDLIBPTH) ./miniperl$(EXE_EXT) -Ilib

# Macros to invoke sort the MANIFEST during build
MANIFEST_SRT = MANIFEST.srt

# Macros to invoke a copy of our fully operational perl during the build.
PERL_EXE = perl$(EXE_EXT)
RUN_PERL = $(LDLIBPTH) $(RUN) ./perl$(EXE_EXT) -Ilib -I.
# Macros to run our tests
RUN_TESTS = $(LDLIBPTH) ./runtests

dynamic_ext =   lib/auto/B/B.so lib/auto/Compress/Raw/Bzip2/Bzip2.so lib/auto/Compress/Raw/Zlib/Zlib.so lib/auto/Cwd/Cwd.so lib/auto/Data/Dumper/Dumper.so lib/auto/Devel/PPPort/PPPort.so lib/auto/Devel/Peek/Peek.so lib/auto/Digest/MD5/MD5.so lib/auto/Digest/SHA/SHA.so lib/auto/Encode/Encode.so lib/auto/Fcntl/Fcntl.so lib/auto/File/DosGlob/DosGlob.so lib/auto/File/Glob/Glob.so lib/auto/Filter/Util/Call/Call.so lib/auto/Hash/Util/Util.so lib/auto/Hash/Util/FieldHash/FieldHash.so lib/auto/I18N/Langinfo/Langinfo.so lib/auto/IO/IO.so lib/auto/IPC/SysV/SysV.so lib/auto/List/Util/Util.so lib/auto/MIME/Base64/Base64.so lib/auto/Math/BigInt/FastCalc/FastCalc.so lib/auto/Opcode/Opcode.so lib/auto/POSIX/POSIX.so lib/auto/PerlIO/encoding/encoding.so lib/auto/PerlIO/mmap/mmap.so lib/auto/PerlIO/via/via.so lib/auto/SDBM_File/SDBM_File.so lib/auto/Socket/Socket.so lib/auto/Storable/Storable.so lib/auto/Sys/Hostname/Hostname.so lib/auto/Sys/Syslog/Syslog.so lib/auto/Time/HiRes/HiRes.so lib/auto/Time/Piece/Piece.so lib/auto/Unicode/Collate/Collate.so lib/auto/Unicode/Normalize/Normalize.so lib/auto/XS/APItest/APItest.so lib/auto/XS/Typemap/Typemap.so lib/auto/attributes/attributes.so lib/auto/mro/mro.so lib/auto/re/re.so lib/auto/threads/threads.so lib/auto/threads/shared/shared.so
dynamic_ext_re = lib/auto/re/re.so
static_ext =  
nonxs_ext =   cpan/Archive-Tar/pm_to_blib dist/Attribute-Handlers/pm_to_blib cpan/AutoLoader/pm_to_blib cpan/CPAN/pm_to_blib cpan/CPAN-Meta/pm_to_blib cpan/CPAN-Meta-Requirements/pm_to_blib cpan/CPAN-Meta-YAML/pm_to_blib dist/Carp/pm_to_blib cpan/Config-Perl-V/pm_to_blib dist/Devel-SelfStubber/pm_to_blib cpan/Digest/pm_to_blib dist/Dumpvalue/pm_to_blib dist/Env/pm_to_blib ext/Errno/pm_to_blib dist/Exporter/pm_to_blib dist/ExtUtils-CBuilder/pm_to_blib cpan/ExtUtils-Constant/pm_to_blib cpan/ExtUtils-Install/pm_to_blib cpan/ExtUtils-MakeMaker/pm_to_blib cpan/ExtUtils-Manifest/pm_to_blib ext/ExtUtils-Miniperl/pm_to_blib cpan/ExtUtils-PL2Bat/pm_to_blib dist/ExtUtils-ParseXS/pm_to_blib cpan/File-Fetch/pm_to_blib ext/File-Find/pm_to_blib cpan/File-Path/pm_to_blib cpan/File-Temp/pm_to_blib ext/FileCache/pm_to_blib dist/Filter-Simple/pm_to_blib dist/FindBin/pm_to_blib cpan/Getopt-Long/pm_to_blib cpan/HTTP-Tiny/pm_to_blib dist/I18N-Collate/pm_to_blib dist/I18N-LangTags/pm_to_blib cpan/IO-Compress/pm_to_blib cpan/IO-Socket-IP/pm_to_blib cpan/IO-Zlib/pm_to_blib cpan/IPC-Cmd/pm_to_blib ext/IPC-Open3/pm_to_blib cpan/JSON-PP/pm_to_blib dist/Locale-Maketext/pm_to_blib cpan/Locale-Maketext-Simple/pm_to_blib cpan/Math-BigInt/pm_to_blib dist/Math-Complex/pm_to_blib cpan/Memoize/pm_to_blib dist/Module-CoreList/pm_to_blib cpan/Module-Load/pm_to_blib cpan/Module-Load-Conditional/pm_to_blib cpan/Module-Loaded/pm_to_blib cpan/Module-Metadata/pm_to_blib cpan/NEXT/pm_to_blib dist/Net-Ping/pm_to_blib cpan/Params-Check/pm_to_blib cpan/Perl-OSType/pm_to_blib ext/PerlIO-scalar/pm_to_blib cpan/PerlIO-via-QuotedPrint/pm_to_blib cpan/Pod-Checker/pm_to_blib cpan/Pod-Escapes/pm_to_blib ext/Pod-Functions/pm_to_blib ext/Pod-Html/pm_to_blib cpan/Pod-Perldoc/pm_to_blib cpan/Pod-Simple/pm_to_blib cpan/Pod-Usage/pm_to_blib dist/Safe/pm_to_blib dist/Search-Dict/pm_to_blib dist/SelfLoader/pm_to_blib cpan/Term-ANSIColor/pm_to_blib cpan/Term-Cap/pm_to_blib dist/Term-Complete/pm_to_blib dist/Term-ReadLine/pm_to_blib cpan/Term-Table/pm_to_blib dist/Test/pm_to_blib cpan/Test-Harness/pm_to_blib cpan/Test-Simple/pm_to_blib cpan/Test2-Suite/pm_to_blib dist/Text-Abbrev/pm_to_blib cpan/Text-Balanced/pm_to_blib cpan/Text-ParseWords/pm_to_blib cpan/Text-Tabs/pm_to_blib dist/Thread-Queue/pm_to_blib dist/Thread-Semaphore/pm_to_blib dist/Tie-File/pm_to_blib ext/Tie-Hash-NamedCapture/pm_to_blib ext/Tie-Memoize/pm_to_blib cpan/Tie-RefHash/pm_to_blib cpan/Time-Local/pm_to_blib dist/XSLoader/pm_to_blib cpan/autodie/pm_to_blib dist/autouse/pm_to_blib dist/base/pm_to_blib cpan/bignum/pm_to_blib dist/constant/pm_to_blib dist/encoding-warnings/pm_to_blib cpan/experimental/pm_to_blib dist/if/pm_to_blib dist/lib/pm_to_blib cpan/libnet/pm_to_blib cpan/parent/pm_to_blib cpan/perlfaq/pm_to_blib cpan/podlators/pm_to_blib cpan/version/pm_to_blib
ext = $(dynamic_ext) $(static_ext) $(nonxs_ext)
DYNALOADER = DynaLoader$(OBJ_EXT)

libs = -lpthread -ldl -lm -lcrypt -lutil -lc 

public = $(PERL_EXE) utilities

shellflags = 

# The /dev/tty or the moral equivalent.
devtty = /dev/tty

# This is set to  MAKE=make if your make command doesn't
# do it for you.
#

# Mention gmake here so it gets probed for by Configure.

# If you're going to use valgrind and it can't be invoked as plain valgrind
# then you'll need to change this, or override it on the make command line.
VALGRIND ?= valgrind
VG_TEST  ?= ./perl -e 1 2>/dev/null

DTRACE =  
DTRACE_H = 

DTRACE_PERLLIB_O =  # "dtrace -G" output for perllib_objs
DTRACE_MINI_O    =     # "dtrace -G" output for common and mini
DTRACE_MAIN_O    =     # "dtrace -G" output for perlmain.o

FIRSTMAKEFILE = skibidi.Makefile

# Any special object files needed by this architecture, e.g. os2/os2.obj
ARCHOBJS = 

.SUFFIXES: .c $(OBJ_EXT) .i .s .c.depends

# grrr
SHELL = /bin/sh

# how to tr(anslate) newlines
TRNL = '\n'

OPTIMIZE = -O2

EXTRAS = 

INSTALLPREFIXEXP = /usr


CCCMD    = sh $(shellflags) cflags "optimize='$(OPTIMIZE)'" $@

CCCMDSRC = sh $(shellflags) cflags "optimize='$(OPTIMIZE)'" $<

CONFIGPM_FROM_CONFIG_SH = lib/Config.pm lib/Config_heavy.pl
CONFIGPM = $(CONFIGPM_FROM_CONFIG_SH) lib/Config_git.pl

CONFIGPOD = lib/Config.pod

CONFIGH = config.h

private = preplibrary $(CONFIGPM) $(CONFIGPOD) git_version.h lib/buildcustomize.pl

# Files to be built with variable substitution before miniperl
# is available.
sh = Makefile.SH cflags.SH config_h.SH makedepend.SH myconfig.SH runtests.SH pod/Makefile.SH

shextract = Makefile cflags config.h makedepend myconfig runtests pod/Makefile

addedbyconf = UU $(shextract)

# Unicode data files generated by mktables
unidatafiles = lib/unicore/Decomposition.pl lib/unicore/TestProp.pl \
	lib/unicore/CombiningClass.pl lib/unicore/Name.pl \
	lib/unicore/UCD.pl lib/unicore/Name.pm \
	lib/unicore/Heavy.pl lib/unicore/mktables.lst

# Directories of Unicode data files generated by mktables
unidatadirs = lib/unicore/To lib/unicore/lib

h = \
    EXTERN.h INTERN.h XSUB.h \
    av.h charclass_invlists.h cop.h cv.h dosish.h embed.h form.h gv.h \
    handy.h hv.h hv_func.h iperlsys.h keywords.h l1_char_class_tab.h \
    mg.h mydtrace.h op.h op_reg_common.h opcode.h pad.h patchlevel.h \
    perl.h perlapi.h perly.h pp.h proto.h regcomp.h regcomp_internal.h \
    regexp.h scope.h sv.h thread.h unixish.h utf8.h util.h warnings.h \
    $(CONFIGH)

c_base = \
    av.c builtin.c caretx.c class.c deb.c doio.c doop.c dquote.c dump.c \
    globals.c gv.c hv.c keywords.c locale.c mathoms.c mg.c mro_core.c \
    numeric.c op.c pad.c peep.c perl.c perlio.c perly.c \
    pp.c pp_ctl.c pp_hot.c pp_pack.c pp_sort.c pp_sys.c \
    reentr.c regcomp.c regcomp_debug.c regcomp_invlist.c regcomp_study.c \
    regcomp_trie.c regexec.c run.c scope.c sv.c taint.c time64.c toke.c \
    universal.c utf8.c util.c \
    $(mallocsrc)

mini_only_src  = opmini.c perlmini.c universalmini.c
mini_only_objs = opmini$(OBJ_EXT) perlmini$(OBJ_EXT) universalmini$(OBJ_EXT)
main_only_objs = op$(OBJ_EXT) perl$(OBJ_EXT) universal$(OBJ_EXT)

c = $(c_base) miniperlmain.c $(mini_only_src)

# split the objects into 3 exclusive sets: those used by both miniperl and
# perl, and those used by just one or the other. Doesn't include the
# actual perl(mini)main.o, nor any dtrace objects.

common_objs = \
    av$(OBJ_EXT) builtin$(OBJ_EXT) caretx$(OBJ_EXT) class$(OBJ_EXT) \
    deb$(OBJ_EXT) doio$(OBJ_EXT) doop$(OBJ_EXT) dquote$(OBJ_EXT) \
    dump$(OBJ_EXT) globals$(OBJ_EXT) gv$(OBJ_EXT) hv$(OBJ_EXT) \
    keywords$(OBJ_EXT) locale$(OBJ_EXT) mathoms$(OBJ_EXT) mg$(OBJ_EXT) \
    mro_core$(OBJ_EXT) numeric$(OBJ_EXT) pad$(OBJ_EXT) peep$(OBJ_EXT) \
    perlio$(OBJ_EXT) perly$(OBJ_EXT) pp$(OBJ_EXT) pp_ctl$(OBJ_EXT) \
    pp_hot$(OBJ_EXT) pp_pack$(OBJ_EXT) pp_sort$(OBJ_EXT) pp_sys$(OBJ_EXT) \
    reentr$(OBJ_EXT) regcomp$(OBJ_EXT) regcomp_debug$(OBJ_EXT) \
    regcomp_invlist$(OBJ_EXT) regcomp_study$(OBJ_EXT) regcomp_trie$(OBJ_EXT) \
    regexec$(OBJ_EXT) run$(OBJ_EXT) scope$(OBJ_EXT) sv$(OBJ_EXT) \
    taint$(OBJ_EXT) time64$(OBJ_EXT) toke$(OBJ_EXT) utf8$(OBJ_EXT) \
    util$(OBJ_EXT) \
    $(mallocobj) $(ARCHOBJS)

miniperl_objs_nodt = $(mini_only_objs) $(common_objs) miniperlmain$(OBJ_EXT)
perllib_objs_nodt  = $(main_only_objs) $(common_objs)


miniperl_objs = $(miniperl_objs_nodt) $(DTRACE_MINI_O)
perllib_objs  = $(perllib_objs_nodt) $(DTRACE_PERLLIB_O)
perlmain_objs = perlmain$(OBJ_EXT) $(DTRACE_MAIN_O)

miniperl_dep = $(miniperl_objs)
perllib_dep = $(perllib_objs)
perlmain_dep = $(perlmain_objs)


perltoc_pod_prereqs = extra.pods pod/perl5402delta.pod pod/perlapi.pod pod/perlintern.pod pod/perlmodlib.pod pod/perluniprops.pod
generated_pods = pod/perltoc.pod $(perltoc_pod_prereqs)
generated_headers = uudmap.h bitcount.h mg_data.h

lintflags = \
    -b \
    -n \
    -p \
    -Ncheck=%all \
    -Nlevel=4 \
    -errchk=parentheses \
    -errhdr=%all \
    -errfmt=src \
    -errtags \
    -erroff=E_ASSIGN_NARROW_CONV \
    -erroff=E_BAD_PTR_CAST \
    -erroff=E_BAD_PTR_CAST_ALIGN \
    -erroff=E_BAD_PTR_INT_COMBINATION \
    -erroff=E_BAD_SIGN_EXTEND \
    -erroff=E_BLOCK_DECL_UNUSED \
    -erroff=E_CASE_FALLTHRU \
    -erroff=E_CONST_EXPR \
    -erroff=E_CONSTANT_CONDITION \
    -erroff=E_END_OF_LOOP_CODE_NOT_REACHED \
    -erroff=E_EQUALITY_NOT_ASSIGNMENT \
    -erroff=E_EXPR_NULL_EFFECT \
    -erroff=E_FALSE_LOGICAL_EXPR \
    -erroff=E_INCL_NUSD \
    -erroff=E_LOOP_EMPTY \
    -erroff=E_MAIN_PARAM \
    -erroff=E_POINTER_TO_OBJECT \
    -erroff=E_PTRDIFF_OVERFLOW \
    -erroff=E_SHIFT_CNT_NEG_TOO_BIG_L \
    -erroff=E_STATIC_UNUSED \
    -erroff=E_TRUE_LOGICAL_EXPR

.c$(OBJ_EXT): 
	@echo `$(CCCMD)` $(PLDLFLAGS) $*.c
	@`$(CCCMD)` $(PLDLFLAGS) $*.c

.c.i:
	@echo `$(CCCMDSRC)` -E $*.c \> $*.i
	@`$(CCCMDSRC)` -E $*.c > $*.i

.c.s:
	@echo `$(CCCMDSRC)` -S $*.c
	@`$(CCCMDSRC)` -S $*.c

all: $(FIRSTMAKEFILE) $(MINIPERL_EXE) $(generated_pods) $(private) $(unidatafiles) $(public) $(dynamic_ext) $(nonxs_ext) extras.make $(MANIFEST_SRT) common_build
	@echo " ";
	@echo "	Everything is up to date. Type '$(MAKE) test' to run test suite."

$(MANIFEST_SRT):	MANIFEST $(PERL_EXE)
	@$(RUN_PERL) Porting/manisort -q || (echo "WARNING: re-sorting MANIFEST"; \
	    $(RUN_PERL) Porting/manisort -q -o MANIFEST; sh -c true)
	@touch $(MANIFEST_SRT)

.PHONY: all utilities

# Both git_version.h and lib/Config_git.pl are built
# by make_patchnum.pl.
git_version.h: lib/Config_git.pl

lib/Config_git.pl: $(MINIPERL_EXE) make_patchnum.pl
	$(MINIPERL) make_patchnum.pl

# make sure that we recompile perl.c if the git version changes
perl$(OBJ_EXT): git_version.h

utils/Makefile: $(MINIPERL_EXE) $(CONFIGPM) utils/Makefile.PL
	$(MINIPERL) utils/Makefile.PL

utilities:	utils/Makefile $(MINIPERL_EXE) $(CONFIGPM) lib/auto/Cwd/Cwd$(DLSUFFIX) FORCE
	@echo " "; echo "	Making utilities"; cd utils; $(LDLIBPTH) $(MAKE) all


# This is now done by installman only if you actually want the man pages.
#	@echo " "; echo "	Making docs"; cd pod; $(MAKE) all;

# Phony target to force checking subdirectories.
# Apparently some makes require an action for the FORCE target.
.PHONY: FORCE
FORCE:
	@sh -c true

opmini.c: op.c
	$(RMS) opmini.c
	$(LNS) op.c opmini.c

opmini$(OBJ_EXT): opmini.c
	echo @`$(CCCMD)` $(PLDLFLAGS) -DPERL_IS_MINIPERL -DPERL_EXTERNAL_GLOB opmini.c
	@`$(CCCMD)` $(PLDLFLAGS) -DPERL_IS_MINIPERL -DPERL_EXTERNAL_GLOB opmini.c

perlmini.c: perl.c
	$(RMS) perlmini.c
	$(LNS) perl.c perlmini.c

perlmini$(OBJ_EXT): perlmini.c
	echo @`$(CCCMD)` $(PLDLFLAGS) -DPERL_IS_MINIPERL -DPERL_EXTERNAL_GLOB perlmini.c
	@`$(CCCMD)` $(PLDLFLAGS) -DPERL_IS_MINIPERL -DPERL_EXTERNAL_GLOB perlmini.c

universalmini.c: universal.c
	$(RMS) universalmini.c
	$(LNS) universal.c universalmini.c

universalmini$(OBJ_EXT): universalmini.c
	echo @`$(CCCMD)` $(PLDLFLAGS) -DPERL_IS_MINIPERL -DPERL_EXTERNAL_GLOB universalmini.c
	@`$(CCCMD)` $(PLDLFLAGS) -DPERL_IS_MINIPERL -DPERL_EXTERNAL_GLOB universalmini.c

cygwin.c: cygwin/cygwin.c
	$(LNS) cygwin/cygwin.c

globals$(OBJ_EXT): $(generated_headers)

uudmap.h mg_data.h: bitcount.h

generate_uudmap$(OBJ_EXT): mg_raw.h

bitcount.h: generate_uudmap$(HOST_EXE_EXT)
	 ./generate_uudmap$(HOST_EXE_EXT) $(generated_headers)
	-@for f in $(generated_headers); do \
	    : $$f; \
	done

generate_uudmap$(HOST_EXE_EXT): generate_uudmap$(OBJ_EXT)
	$(CC) -o generate_uudmap$(EXE_EXT) $(LDFLAGS) generate_uudmap$(OBJ_EXT) $(libs)

perlmain.c: $(MINIPERL_EXE) ext/ExtUtils-Miniperl/pm_to_blib
	$(MINIPERL) -MExtUtils::Miniperl -e 'writemain(\"perlmain.c", @ARGV)' DynaLoader $(static_ext)

# The file ext.libs is a list of libraries that must be linked in
# for static extensions, e.g. -lm -lgdbm, etc.  The individual
# static extension Makefile's add to it.
ext.libs: $(static_ext)
	-@test -f ext.libs || touch ext.libs

$(LIBPERL): $& $(perllib_dep) $(DYNALOADER) $(LIBPERLEXPORT)
	rm -f $(LIBPERL)
	$(AR) rc $(LIBPERL) $(perllib_objs) $(DYNALOADER)
	@$(ranlib) $(LIBPERL)

# How to build executables.

# The $& notation tells Sequent machines that it can do a parallel make,
# and is harmless otherwise.
# The miniperl -w -MExporter line is a basic cheap test to catch errors
# before make goes on to run preplibrary and then MakeMaker on extensions.
# This is very handy because later errors are often caused by miniperl
# build problems but that's not obvious to the novice.
# The Module used here must not depend on Config or any extensions.

# The seemingly cranky ordering of having $(MINIPERL_EXE) depend on
# lib/buildcustomize.pl despite the reality that lib/buildcustomize.pl needs
# miniperl to exist first permits us to
# a) have one rule generate both miniperl and lib/buildcustomize.pl
#    (so that lib/buildcustomize.pl is always available. This simplifies things)
# b) have the rest of the Makefile depend on the more obvious $(MINIPERL_EXE)

$(MINIPERL_EXE): lib/buildcustomize.pl
	@touch $(MINIPERL_EXE)

lib/buildcustomize.pl: $& $(miniperl_dep) write_buildcustomize.pl
	-@rm -f miniperl.xok
	$(CC) $(CLDFLAGS) -o $(MINIPERL_EXE) \
	    $(miniperl_objs) $(libs)
	$(LDLIBPTH) ./miniperl$(HOST_EXE_EXT) -w -Ilib -Idist/Exporter/lib -MExporter -e '<?>' || sh -c 'echo >&2 Failed to build miniperl.  Please run make minitest; exit 1'
	$(MINIPERL) -f write_buildcustomize.pl

$(PERL_EXE): $& $(perlmain_dep) $(LIBPERL) $(static_ext) ext.libs $(PERLEXPORT) write_buildcustomize.pl
	-@rm -f miniperl.xok
	$(SHRPENV) $(CC) -o perl $(CLDFLAGS) $(CCDLFLAGS) $(perlmain_objs) $(static_ext) $(LLIBPERL) `cat ext.libs` $(libs)

.PHONY: makeppport
makeppport: $(MINIPERL_EXE) $(CONFIGPM) $(nonxs_ext)
	$(MINIPERL) mkppport


.PHONY: preplibrary common_build
preplibrary: $(MINIPERL_EXE) $(CONFIGPM) $(PREPLIBRARY_LIBPERL)

$(CONFIGPM_FROM_CONFIG_SH): $(CONFIGPOD)

$(CONFIGPOD): config.sh $(MINIPERL_EXE) configpm Porting/Glossary lib/Config_git.pl
	$(MINIPERL) configpm

unidatafiles $(unidatafiles) pod/perluniprops.pod: uni.data

uni.data: $(MINIPERL_EXE) $(CONFIGPM) lib/unicore/mktables $(nonxs_ext)
	$(MINIPERL) lib/unicore/mktables -C lib/unicore -P pod -maketest -makenormtest -makelist -p
#	Commented out so always runs, mktables looks at far more files than we
#	can in this makefile to decide if needs to run or not
#	touch uni.data

# $(PERL_EXE) and ext because pod_lib.pl needs Digest::MD5
# But also this ensures that all extensions are built before we try to scan
# them, which picks up Devel::PPPort's documentation.
pod/perltoc.pod: $(perltoc_pod_prereqs) $(PERL_EXE) $(ext) pod/buildtoc
	$(RUN_PERL) -f pod/buildtoc -q

pod/perlapi.pod: pod/perlintern.pod

pod/perlintern.pod: $(MINIPERL_EXE) autodoc.pl embed.fnc
	$(MINIPERL) autodoc.pl

pod/perlmodlib.pod: $(MINIPERL_EXE) pod/perlmodlib.PL MANIFEST
	$(MINIPERL) pod/perlmodlib.PL -q

pod/perl5402delta.pod: pod/perldelta.pod
	$(RMS) pod/perl5402delta.pod
	$(LNS) perldelta.pod pod/perl5402delta.pod

extra.pods: $(MINIPERL_EXE)
	-@test ! -f extra.pods || rm -f `cat extra.pods`
	-@rm -f extra.pods
	-@for x in `grep -l '^=[a-z]' README.* | grep -v README.vms` ; do \
	    nx=`echo $$x | sed -e "s/README\.//"`; \
	    $(LNS) ../$$x "pod/perl"$$nx".pod" ; \
	    echo "pod/perl"$$nx".pod" >> extra.pods ; \
	done

extras.make: $(PERL_EXE)
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(RUN_PERL) -MCPAN -e '@ARGV&&make(@ARGV)' `cat extras.lst`

extras.test: $(PERL_EXE)
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(RUN_PERL) -MCPAN -e '@ARGV&&test(@ARGV)' `cat extras.lst`

extras.install: $(PERL_EXE)
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(RUN_PERL) -MCPAN -e '@ARGV&&install(@ARGV)' `cat extras.lst`

.PHONY: install install-strip install-all install-verbose install-silent \
	no-install install.perl install.man install.html

# Set this to an empty string to avoid an attempt of rebuild before install
INSTALL_DEPENDENCE = all

no_install no-install: install-notify

install: install-all

install_all install-all: $(INSTALL_DEPENDENCE) installperl all installman
	$(RUN_PERL) installperl --destdir=$(DESTDIR)  $(INSTALLFLAGS) $(STRIPFLAGS)
	$(RUN_PERL) installman --destdir=$(DESTDIR) 
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(RUN_PERL) -Ilib -MCPAN -e '@ARGV&&install(@ARGV)' `cat extras.lst`

install_notify install-notify: $(INSTALL_DEPENDENCE) installperl all installman
	$(RUN_PERL) installperl --destdir=$(DESTDIR) --notify $(INSTALLFLAGS) $(STRIPFLAGS)
	$(RUN_PERL) installman --destdir=$(DESTDIR) --notify

install_silent install-silent: $(INSTALL_DEPENDENCE) installperl all installman
	$(RUN_PERL) installperl --destdir=$(DESTDIR) --silent $(INSTALLFLAGS) $(STRIPFLAGS)
	$(RUN_PERL) installman --destdir=$(DESTDIR) --silent
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(RUN_PERL) -Ilib -MCPAN -e '@ARGV&&install(@ARGV)' `cat extras.lst`

install_strip install-strip: $(INSTALL_DEPENDENCE) installperl all installman
	$(RUN_PERL) installperl --destdir=$(DESTDIR) --strip $(INSTALLFLAGS) $(STRIPFLAGS)
	$(RUN_PERL) installman --destdir=$(DESTDIR) --strip
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(RUN_PERL) -Ilib -MCPAN -e '@ARGV&&install(@ARGV)' `cat extras.lst`

install_verbose install-verbose: $(INSTALL_DEPENDENCE) installperl all installman
	$(RUN_PERL) installperl --destdir=$(DESTDIR) --verbose $(INSTALLFLAGS) $(STRIPFLAGS)
	$(RUN_PERL) installman --destdir=$(DESTDIR) --verbose
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(RUN_PERL) -Ilib -MCPAN -e '@ARGV&&install(@ARGV)' `cat extras.lst`
install.perl:	$(INSTALL_DEPENDENCE) installperl
	$(RUN_PERL) installperl --destdir=$(DESTDIR) $(INSTALLFLAGS) $(STRIPFLAGS)
	-@test ! -s extras.lst || PATH="`pwd`:\${PATH}" PERL5LIB="`pwd`/lib" \$(RUN_PERL) -Ilib -MCPAN -e '@ARGV&&install(@ARGV)' `cat extras.lst`

install.man:	all installman
	$(RUN_PERL) installman --destdir=$(DESTDIR) $(INSTALLFLAGS)

# XXX Experimental. Hardwired values, but useful for testing.
# Eventually Configure could ask for some of these values.
install.html: all installhtml
	-@test -f README.vms && cd vms && $(LNS) ../README.vms README_vms.pod && cd ..
	$(RUN_PERL) installhtml   \
      --podroot=. --podpath=. --recurse  \
      --htmldir=$(privlib)/html   \
      --splithead=pod/perlipc     \
      --splititem=pod/perlfunc    \
      --ignore=Porting/Maintainers.pm,Porting/pumpkin.pod,Porting/repository.pod \
      --verbose

# I now supply perly.c with the kits, so the following section is
# used only if you force bison to run by saying
# 	make regen_perly
# You normally shouldn't remake perly.[ch].

.PHONY: regen_perly

run_byacc run-byacc:
	@echo "run_byacc is obsolete; try 'make regen_perly' instead"

# this outputs perly.h, perly.act and perly.tab
regen_perly regen-perly:
	perl regen_perly.pl

# We don't want to regenerate perly.c and perly.h, but they might
# appear out-of-date after a patch is applied or a new distribution is
# made.
perly.c: perly.y
	-@sh -c true

perly.h: perly.y
	-@sh -c true

SYM  = globvar.sym perlio.sym

SYMH = perlvars.h intrpvar.h

CHMOD_W = chmod +w

# The following files are generated automatically
#	embed.pl:	proto.h embed.h embedvar.h
#	opcode.pl:	opcode.h opnames.h pp_proto.h
#	regcomp.pl:	regnodes.h
#	warnings.pl:	warnings.h lib/warnings.pm
#	feature.pl:	feature.h lib/feature.pm
#	locale.pl:	locale_table.h
# The correct versions should be already supplied with the perl kit,
# in case you don't have perl available.
# To force them to be regenerated, run
#       perl regen.pl
# with your existing copy of perl
# (make regen_headers is kept for backwards compatibility)

.PHONY: regen_headers regen_all

regen:	FORCE
	-perl regen.pl

regen_headers regen-headers:	FORCE
	-perl regen.pl -v

regen_meta regen-meta:  META.yml META.json

META.yml:   FORCE
	PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(RUN_PERL) Porting/makemeta -y

META.json:   FORCE
	PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(RUN_PERL) Porting/makemeta -j


regen_all regen-all: regen regen_meta

.PHONY:	manisort manicheck

manisort:	FORCE
	@perl Porting/manisort -q || (echo "WARNING: re-sorting MANIFEST"; \
		perl Porting/manisort -q -o MANIFEST; sh -c true)

manicheck:	FORCE
	perl Porting/manicheck

# Extensions:
# Names added to $(dynamic_ext) or $(static_ext) or $(nonxs_ext) will
# automatically get built.  There should ordinarily be no need to change
# any of this part of makefile.
#
# The dummy dependency is a place holder in case $(dynamic_ext) or
# $(static_ext) is empty.
#
# DynaLoader may be needed for extensions that use Makefile.PL.

$(DYNALOADER):	$(MINIPERL_EXE) lib/buildcustomize.pl preplibrary FORCE $(nonxs_ext)
	$(MINIPERL) make_ext.pl $@ $(MAKE_EXT_ARGS) MAKE="$(MAKE)" LIBPERL_A=$(LIBPERL) LINKTYPE=static $(STATIC_LDFLAGS)

d_dummy $(dynamic_ext):	$(MINIPERL_EXE) lib/buildcustomize.pl preplibrary makeppport $(DYNALOADER) FORCE $(PERLEXPORT) $(LIBPERL)
	$(MINIPERL) make_ext.pl $@ $(MAKE_EXT_ARGS) MAKE="$(MAKE)" LIBPERL_A=$(LIBPERL) LINKTYPE=dynamic

s_dummy $(static_ext):	$(MINIPERL_EXE) lib/buildcustomize.pl preplibrary makeppport $(DYNALOADER) FORCE
	$(MINIPERL) make_ext.pl $@ $(MAKE_EXT_ARGS) MAKE="$(MAKE)" LIBPERL_A=$(LIBPERL) LINKTYPE=static $(STATIC_LDFLAGS)

n_dummy $(nonxs_ext):	$(MINIPERL_EXE) lib/buildcustomize.pl preplibrary FORCE
	$(MINIPERL) make_ext.pl $@ $(MAKE_EXT_ARGS) MAKE="$(MAKE)" LIBPERL_A=$(LIBPERL)

cpan/Pod-Simple/pm_to_blib: dist/if/pm_to_blib
ext/Pod-Functions/pm_to_blib: cpan/Pod-Simple/pm_to_blib cpan/Pod-Escapes/pm_to_blib pod/perlfunc.pod
cpan/IO-Compress/pm_to_blib: dist/lib/pm_to_blib

lib/auto/Math/BigInt/FastCalc/FastCalc.so: lib/auto/List/Util/Util.so
lib/auto/Unicode/Normalize/Normalize.so: uni.data

.PHONY: printconfig
printconfig:
	@eval `$(RUN_PERL) -V:$(CONFIGVAR)`; echo $$$(CONFIGVAR)

.PHONY: clean _tidy _mopup _cleaner1 _cleaner2 \
	realclean _realcleaner clobber _clobber \
	distclean veryclean _verycleaner

clean:		realclean

realclean:	_realcleaner _mopup
	@echo "Note that '$(MAKE) realclean' does not delete config.sh or Policy.sh"

_clobber:
	-@rm -f Cross/run-* Cross/to-* Cross/from-* Cross/mkdir
	-rm -rf host
	rm -f t/test_state
	rm -f config.sh cppstdin Policy.sh extras.lst
	rm -f $(MANIFEST_SRT)

clobber:	_realcleaner _mopup _clobber

distclean:	clobber

# Like distclean but also removes emacs backups and *.orig.
veryclean:	_verycleaner _mopup _clobber
	-@rm -f Obsolete Wanted

# Do not 'make _mopup' directly.
_mopup:
	rm -f *$(OBJ_EXT) *$(LIB_EXT) all perlmain.c $(mini_only_src) generate_uudmap$(EXE_EXT) $(generated_headers)
	-rmdir .depending
	-rm *.depends makedepend_file
	-@test -f extra.pods && rm -f `cat extra.pods`
	-@test -f vms/README_vms.pod && rm -f vms/README_vms.pod
	-rm -f perl.exp ext.libs $(generated_pods) uni.data $(mini_only_objs) pod/roffitall
	-rm -f perl.export perl.dll perl.libexp perl.map perl.def
	-rm -f *perl.xok
	-rm -f cygwin.c libperl*.def libperl*.dll cygperl*.dll *.exe.stackdump
	-rm -f $(PERL_EXE) $(MINIPERL_EXE) $(LIBPERL) libperl.*
	-rm -f config.arch config.over $(DTRACE_H)

_cleaner1:
	-cd os2; rm -f Makefile
	-cd pod; $(LDLIBPTH) $(MAKE) $(CLEAN)
	-cd utils; $(LDLIBPTH) $(MAKE) $(CLEAN)
	-@if test -f $(MINIPERL_EXE) ; then \
	for x in $(DYNALOADER) $(dynamic_ext) $(static_ext) $(nonxs_ext) ; do \
	$(MINIPERL) make_ext.pl --target=$(CLEAN) $$x MAKE="$(MAKE)" ; \
	done ; \
	else \
	sh $(CLEAN).sh ; \
	fi
	rm -f realclean.sh veryclean.sh
	-rm -f `grep -v ^# mkppport.lst | grep . | sed -e 's/$$/\/ppport.h/'`

# Dear POSIX, thanks for making the default to xargs to be
# run once if nothing is passed in. It is such a great help.

# Some systems do not support "?", so keep these files separate.

# The Time::HiRes Makefile *should* remove dist/Time-HiRes/xdefine for 'clean',
# but it's possible to get a rebuilt checkout into a state where it can't run
# distclean, and can't recover until the file is gone.
# There's no harm in adding it to the top level 'distclean' target - it should
# anyway by then, and miniperl is long gone.
# Add new rules before that line - the next line (rm -f so_locations ...) is
# used as a placeholder by a regen script.
_cleaner2:
	-rm -f core.*perl.*.? t/core.perl.*.? .?*.c
	rm -f core *perl.core t/core t/*perl.core core.* t/core.*
	rm -f t/$(PERL_EXE) t/rantests
	rm -rf t/tmp*
	rm -rf $(addedbyconf)
	rm -f $(FIRSTMAKEFILE) $(FIRSTMAKEFILE).old makefile.old utils/Makefile
	rm -f $(private)
	rm -rf $(unidatafiles) $(unidatadirs)
	rm -rf lib/auto
	rm -f lib/.exists lib/*/.exists lib/*/*/.exists
	rm -f h2ph.man
	rm -rf .config
	rm -f preload
	rm -f pod2htmd.tmp
	rm -rf pod/perlfunc pod/perlipc
	-rmdir ext/B/lib
	-rm -f dist/Time-HiRes/xdefine
	rm -f so_locations $(LIBPERL_NONSHR)
	-rmdir lib/version lib/threads lib/inc/ExtUtils lib/inc lib/encoding
	-rmdir lib/autodie/exception lib/autodie/Scope lib/autodie lib/XS
	-rmdir lib/Win32API lib/VMS lib/Unicode/Collate/Locale
	-rmdir lib/Unicode/Collate/CJK lib/Unicode/Collate lib/Tie/Hash
	-rmdir lib/Thread lib/Text lib/Test2/Workflow/Task lib/Test2/Workflow
	-rmdir lib/Test2/Util/Table lib/Test2/Util lib/Test2/Tools
	-rmdir lib/Test2/Require lib/Test2/Plugin
	-rmdir lib/Test2/Manual/Tooling/Plugin lib/Test2/Manual/Tooling
	-rmdir lib/Test2/Manual/Testing lib/Test2/Manual/Anatomy
	-rmdir lib/Test2/Manual lib/Test2/IPC/Driver lib/Test2/IPC
	-rmdir lib/Test2/Hub/Interceptor lib/Test2/Hub lib/Test2/Formatter
	-rmdir lib/Test2/EventFacet/Info lib/Test2/EventFacet
	-rmdir lib/Test2/Event/TAP lib/Test2/Event lib/Test2/Compare
	-rmdir lib/Test2/Bundle lib/Test2/AsyncSubtest/Event
	-rmdir lib/Test2/AsyncSubtest lib/Test2/API/InterceptResult
	-rmdir lib/Test2/API lib/Test2 lib/Test/use lib/Test/Tester
	-rmdir lib/Test/Builder/Tester lib/Test/Builder/IO lib/Test/Builder
	-rmdir lib/Test lib/Term/Table lib/Term lib/TAP/Parser/YAMLish
	-rmdir lib/TAP/Parser/SourceHandler lib/TAP/Parser/Scheduler
	-rmdir lib/TAP/Parser/Result lib/TAP/Parser/Iterator lib/TAP/Parser
	-rmdir lib/TAP/Harness lib/TAP/Formatter/File
	-rmdir lib/TAP/Formatter/Console lib/TAP/Formatter lib/TAP
	-rmdir lib/Sys/Syslog lib/Sys lib/Sub lib/Search lib/Scalar
	-rmdir lib/Pod/Text lib/Pod/Simple lib/Pod/Perldoc lib/Pod/Html
	-rmdir lib/PerlIO/via lib/PerlIO lib/Perl lib/Parse/CPAN lib/Parse
	-rmdir lib/Params lib/Net/FTP lib/Module/Load lib/Module/CoreList
	-rmdir lib/Module lib/Memoize lib/Math/BigRat lib/Math/BigInt
	-rmdir lib/Math/BigFloat lib/Math lib/MIME lib/Locale/Maketext
	-rmdir lib/Locale lib/List/Util lib/List lib/JSON/PP lib/JSON lib/IPC
	-rmdir lib/IO/Uncompress/Adapter lib/IO/Uncompress lib/IO/Socket
	-rmdir lib/IO/Compress/Zlib lib/IO/Compress/Zip lib/IO/Compress/Gzip
	-rmdir lib/IO/Compress/Base lib/IO/Compress/Adapter lib/IO/Compress
	-rmdir lib/IO lib/I18N/LangTags lib/I18N lib/Hash/Util lib/Hash
	-rmdir lib/HTTP lib/Getopt/Long lib/Filter/Util lib/Filter
	-rmdir lib/File/Spec lib/ExtUtils/Typemaps lib/ExtUtils/ParseXS
	-rmdir lib/ExtUtils/MakeMaker/version lib/ExtUtils/MakeMaker
	-rmdir lib/ExtUtils/Liblist lib/ExtUtils/Constant lib/ExtUtils/Command
	-rmdir lib/ExtUtils/CBuilder/Platform/Windows
	-rmdir lib/ExtUtils/CBuilder/Platform lib/ExtUtils/CBuilder
	-rmdir lib/Exporter lib/Encode/Unicode lib/Encode/MIME/Header
	-rmdir lib/Encode/MIME lib/Encode/KR lib/Encode/JP lib/Encode/CN
	-rmdir lib/Encode lib/Digest lib/Devel lib/Data lib/Config/Perl
	-rmdir lib/Compress/Raw lib/Compress lib/Carp lib/CPAN/Plugin
	-rmdir lib/CPAN/Meta/Requirements lib/CPAN/Meta/History lib/CPAN/Meta
	-rmdir lib/CPAN/LWP lib/CPAN/Kwalify lib/CPAN/HTTP lib/CPAN/FTP
	-rmdir lib/CPAN/Exception lib/CPAN/API lib/CPAN lib/Attribute
	-rmdir lib/Archive/Tar lib/Archive lib/App/Prove/State/Result
	-rmdir lib/App/Prove/State lib/App/Prove lib/App lib/Amiga

_realcleaner:
	@$(LDLIBPTH) $(MAKE) _cleaner1 CLEAN=distclean
	@$(LDLIBPTH) $(MAKE) _cleaner2

_verycleaner:
	@$(LDLIBPTH) $(MAKE) _cleaner1 CLEAN=veryclean
	@$(LDLIBPTH) $(MAKE) _cleaner2
	-rm -f *~ *.orig */*~ */*.orig */*/*~ */*/*.orig

.PHONY: lint
lint: $(c)
	rm -f *.ln
	lint $(lintflags) -DPERL_CORE -D_REENTRANT -DDEBUGGING -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 $(c)

cscopeflags = -Rb  # Recursive, build-only.

.PHONY:	cscope
# To query the cscope.out "cscope -dLnsymbol" where n = 0 means uses,
# 1 = definitions, 2 = callees, 3 = callers, for example
# "cscope -dL1Perl_mg_set" or run cscope interactively (no arguments).
cscope.out cscope: $(c) $(h)
	cscope $(cscopeflags)

# Need to unset during recursion to go out of loop.
# The README below ensures that the dependency list is never empty and
# that when MAKEDEPEND is empty $(FIRSTMAKEFILE) doesn't need rebuilding.

MAKEDEPEND = Makefile makedepend_file makedepend

# Mimux FIX: We already provide a skibidi.Makefile. NO need to run stupid
# Makefile.SH type BULLSHIT again.
$(FIRSTMAKEFILE):
	true

#$(FIRSTMAKEFILE):	README $(MAKEDEPEND)
#	$(MAKE) depend MAKEDEPEND=

Makefile: Makefile.SH config.sh
	$(SHELL) Makefile.SH

cflags: cflags.SH config.sh
	$(SHELL) cflags.SH

config.h: config_h.SH config.sh
	$(SHELL) config_h.SH

makedepend: makedepend.SH config.sh
	$(SHELL) makedepend.SH

myconfig: myconfig.SH config.sh
	$(SHELL) myconfig.SH

runtests: runtests.SH config.sh
	$(SHELL) runtests.SH

pod/Makefile: pod/Makefile.SH config.sh
	$(SHELL) pod/Makefile.SH

.PHONY: depend
depend: makedepend $(DTRACE_H) $(generated_headers)
	sh ./makedepend MAKE="$(MAKE)" cflags

.c.c.depends:
	sh ./makedepend_file $< $@ cflags

.PHONY: test check test_prep test_prep_nodll test_prep_pre \
	test_prep_reonly test_tty test-tty test_notty test-notty \
	test_harness test_harness_notty minitest test-reonly _test

# The _test target is there just for Test::Smoke, which does a make test_prep
# always before invoking this target, thus preventing checking again
_test:
	$(RUN_TESTS) choose

# Cannot delegate rebuilding of t/perl to make
# to allow interlaced test and minitest

# Architecture-neutral stuff:

test_prep_pre: preplibrary utilities $(nonxs_ext)
test_prep test-prep: test_prep_pre $(MINIPERL_EXE) $(unidatafiles) $(PERL_EXE) \
	$(dynamic_ext) $(TEST_PERL_DLL) runtests $(generated_pods) common_build
	cd t && (rm -f $(PERL_EXE); $(LNS) ../$(PERL_EXE) $(PERL_EXE))

test_prep_reonly: $(MINIPERL_EXE) $(PERL_EXE) $(dynamic_ext_re) $(TEST_PERL_DLL)
	$(MINIPERL) make_ext.pl $(dynamic_ext_re) MAKE="$(MAKE)" LIBPERL_A=$(LIBPERL) LINKTYPE=dynamic
	cd t && (rm -f $(PERL_EXE); $(LNS) ../$(PERL_EXE) $(PERL_EXE))

test check: test_prep
	$(RUN_TESTS) choose

test_tty test-tty: test_prep
	$(RUN_TESTS) tty

test_notty test-notty: test_prep
	$(RUN_TESTS) no-tty

# Targets for valgrind testing:

test.valgrind check.valgrind:	test_prep
	@echo "Checking usemymalloc='n' in config.sh..."
	@grep "^usemymalloc="    config.sh
	@grep "^usemymalloc='n'" config.sh >/dev/null || exit 1
	@echo "And of course you have to have valgrind..."
	$(VALGRIND) $(VG_TEST) || exit 1
	PERL_VALGRIND=1 VALGRIND='$(VALGRIND)' TESTFILE=harness $(RUN_TESTS) choose

# minitest can't depend on lib/Config.pm because that might be where miniperl
# is crashing.
minitest_prep: $(MINIPERL_EXE)
	-@test -f lib/Config.pm || $(MAKE) lib/Config.pm $(unidatafiles)
	@echo " "
	@echo "You may see some irrelevant test failures if you have been unable"
	@echo "to build lib/Config.pm, or the Unicode data files."
	@echo " "
	cd t && (rm -f $(PERL_EXE); $(LNS) ../$(MINIPERL_EXE) $(PERL_EXE))

MINITEST_TESTS = base/*.t comp/*.t cmd/*.t run/*.t io/*.t re/*.t opbasic/*.t op/*.t uni/*.t perf/*.t

minitest: minitest_prep
	cd t && $(RUN_PERL) TEST $(MINITEST_TESTS) <$(devtty)

minitest-notty minitest_notty: minitest_prep
	cd t && PERL_SKIP_TTY_TEST=1 $(RUN_PERL) TEST $(MINITEST_TESTS)

# Test via harness

test_harness test-harness: test_prep
	TESTFILE=harness $(RUN_TESTS) choose

test_harness_notty: test_prep
	HARNESS_NOTTY=1 TESTFILE=harness $(RUN_TESTS) choose

test_reonly test-reonly: test_prep_reonly
	TEST_ARGS='re/*.t ../ext/re/t/*.t' PERL_TEST_HARNESS_ASAP=1 TESTFILE=harness $(RUN_TESTS) choose


# Porting tests (well-formedness of pod, manifest, etc)

test_porting test-porting: test_prep
	TEST_ARGS='porting/*.t lib/diagnostics.t' TESTFILE=harness $(RUN_TESTS) choose


# intended as a common way to add dependencies to test-prep and all
common_build: 


# Handy way to run perlbug -ok without having to install and run the
# installed perlbug. We don't re-run the tests here - we trust the user.
# Please *don't* use this unless all tests pass.
# If you want to report test failures, use "make nok" instead.

.PHONY: ok okfile oknack okfilenack nok nokfile noknack nokfilenack

ok:	utilities
	$(RUN_PERL) utils/perlbug -ok -s '(UNINSTALLED)'

okfile:	utilities
	$(RUN_PERL) utils/perlbug -ok -s '(UNINSTALLED)' -F perl.ok

oknack:	utilities
	$(RUN_PERL) utils/perlbug -ok -s '(UNINSTALLED)' -A

okfilenack:	utilities
	$(RUN_PERL) utils/perlbug -ok -s '(UNINSTALLED)' -F perl.ok -A

nok:	utilities
	$(RUN_PERL) utils/perlbug -nok -s '(UNINSTALLED)'

nokfile:	utilities
	$(RUN_PERL) utils/perlbug -nok -s '(UNINSTALLED)' -F perl.nok

noknack:	utilities
	$(RUN_PERL) utils/perlbug -nok -s '(UNINSTALLED)' -A

nokfilenack:	utilities
	$(RUN_PERL) utils/perlbug -nok -s '(UNINSTALLED)' -F perl.nok -A

.PHONY: clist hlist

clist:	$(c)
	echo $(c) | tr ' ' $(TRNL) >.clist

hlist:  $(h)
	echo $(h) | tr ' ' $(TRNL) >.hlist

.PHONY: distcheck
distcheck: FORCE
	perl '-MExtUtils::Manifest=&fullcheck' -e 'fullcheck()'

.PHONY: ctags

TAGS: $(c_base) $(h)
	etags $(c_base) $(h)

ctags:
	ctags -f Tags -N --totals --languages=c --langmap=c:+.h  --exclude=opmini.c --exclude=perlmini.c --exclude=universalmini.c *.c *.h

# AUTOMATICALLY GENERATED MAKE DEPENDENCIES--PUT NOTHING BELOW THIS LINE
# If this runs make out of memory, delete /usr/include lines.
av$(OBJ_EXT): CROSS_ROOT/include/alloca.h
av$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
av$(OBJ_EXT): CROSS_ROOT/include/assert.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
av$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
av$(OBJ_EXT): CROSS_ROOT/include/ctype.h
av$(OBJ_EXT): CROSS_ROOT/include/dirent.h
av$(OBJ_EXT): CROSS_ROOT/include/endian.h
av$(OBJ_EXT): CROSS_ROOT/include/errno.h
av$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
av$(OBJ_EXT): CROSS_ROOT/include/features.h
av$(OBJ_EXT): CROSS_ROOT/include/float.h
av$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
av$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
av$(OBJ_EXT): CROSS_ROOT/include/limits.h
av$(OBJ_EXT): CROSS_ROOT/include/locale.h
av$(OBJ_EXT): CROSS_ROOT/include/math.h
av$(OBJ_EXT): CROSS_ROOT/include/netdb.h
av$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
av$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
av$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
av$(OBJ_EXT): CROSS_ROOT/include/signal.h
av$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
av$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
av$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
av$(OBJ_EXT): CROSS_ROOT/include/stddef.h
av$(OBJ_EXT): CROSS_ROOT/include/stdint.h
av$(OBJ_EXT): CROSS_ROOT/include/stdio.h
av$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
av$(OBJ_EXT): CROSS_ROOT/include/string.h
av$(OBJ_EXT): CROSS_ROOT/include/strings.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
av$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
av$(OBJ_EXT): CROSS_ROOT/include/time.h
av$(OBJ_EXT): CROSS_ROOT/include/unistd.h
av$(OBJ_EXT): CROSS_ROOT/include/wchar.h
av$(OBJ_EXT): EXTERN.h
av$(OBJ_EXT): av.c
av$(OBJ_EXT): av.h
av$(OBJ_EXT): charclass_invlists.h
av$(OBJ_EXT): config.h
av$(OBJ_EXT): cop.h
av$(OBJ_EXT): cv.h
av$(OBJ_EXT): embed.h
av$(OBJ_EXT): embedvar.h
av$(OBJ_EXT): form.h
av$(OBJ_EXT): gv.h
av$(OBJ_EXT): handy.h
av$(OBJ_EXT): hv.h
av$(OBJ_EXT): hv_func.h
av$(OBJ_EXT): hv_macro.h
av$(OBJ_EXT): inline.h
av$(OBJ_EXT): intrpvar.h
av$(OBJ_EXT): iperlsys.h
av$(OBJ_EXT): locale_table.h
av$(OBJ_EXT): mg.h
av$(OBJ_EXT): mg_vtable.h
av$(OBJ_EXT): mydtrace.h
av$(OBJ_EXT): nostdio.h
av$(OBJ_EXT): op.h
av$(OBJ_EXT): op_reg_common.h
av$(OBJ_EXT): opcode.h
av$(OBJ_EXT): opnames.h
av$(OBJ_EXT): overload.h
av$(OBJ_EXT): pad.h
av$(OBJ_EXT): parser.h
av$(OBJ_EXT): patchlevel.h
av$(OBJ_EXT): perl.h
av$(OBJ_EXT): perl_langinfo.h
av$(OBJ_EXT): perl_siphash.h
av$(OBJ_EXT): perlio.h
av$(OBJ_EXT): perlstatic.h
av$(OBJ_EXT): perlvars.h
av$(OBJ_EXT): perly.h
av$(OBJ_EXT): pp.h
av$(OBJ_EXT): pp_proto.h
av$(OBJ_EXT): proto.h
av$(OBJ_EXT): regcharclass.h
av$(OBJ_EXT): regexp.h
av$(OBJ_EXT): sbox32_hash.h
av$(OBJ_EXT): scope.h
av$(OBJ_EXT): scope_types.h
av$(OBJ_EXT): sv.h
av$(OBJ_EXT): sv_inline.h
av$(OBJ_EXT): thread.h
av$(OBJ_EXT): unicode_constants.h
av$(OBJ_EXT): unixish.h
av$(OBJ_EXT): utf8.h
av$(OBJ_EXT): util.h
av$(OBJ_EXT): warnings.h
av$(OBJ_EXT): zaphod32_hash.h
av$(OBJ_EXT): cflags
builtin$(OBJ_EXT): CROSS_ROOT/include/alloca.h
builtin$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
builtin$(OBJ_EXT): CROSS_ROOT/include/assert.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
builtin$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
builtin$(OBJ_EXT): CROSS_ROOT/include/ctype.h
builtin$(OBJ_EXT): CROSS_ROOT/include/dirent.h
builtin$(OBJ_EXT): CROSS_ROOT/include/endian.h
builtin$(OBJ_EXT): CROSS_ROOT/include/errno.h
builtin$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
builtin$(OBJ_EXT): CROSS_ROOT/include/features.h
builtin$(OBJ_EXT): CROSS_ROOT/include/float.h
builtin$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
builtin$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
builtin$(OBJ_EXT): CROSS_ROOT/include/limits.h
builtin$(OBJ_EXT): CROSS_ROOT/include/locale.h
builtin$(OBJ_EXT): CROSS_ROOT/include/math.h
builtin$(OBJ_EXT): CROSS_ROOT/include/netdb.h
builtin$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
builtin$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
builtin$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
builtin$(OBJ_EXT): CROSS_ROOT/include/signal.h
builtin$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
builtin$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
builtin$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
builtin$(OBJ_EXT): CROSS_ROOT/include/stddef.h
builtin$(OBJ_EXT): CROSS_ROOT/include/stdint.h
builtin$(OBJ_EXT): CROSS_ROOT/include/stdio.h
builtin$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
builtin$(OBJ_EXT): CROSS_ROOT/include/string.h
builtin$(OBJ_EXT): CROSS_ROOT/include/strings.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
builtin$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
builtin$(OBJ_EXT): CROSS_ROOT/include/time.h
builtin$(OBJ_EXT): CROSS_ROOT/include/unistd.h
builtin$(OBJ_EXT): CROSS_ROOT/include/wchar.h
builtin$(OBJ_EXT): EXTERN.h
builtin$(OBJ_EXT): XSUB.h
builtin$(OBJ_EXT): av.h
builtin$(OBJ_EXT): builtin.c
builtin$(OBJ_EXT): charclass_invlists.h
builtin$(OBJ_EXT): config.h
builtin$(OBJ_EXT): cop.h
builtin$(OBJ_EXT): cv.h
builtin$(OBJ_EXT): embed.h
builtin$(OBJ_EXT): embedvar.h
builtin$(OBJ_EXT): form.h
builtin$(OBJ_EXT): gv.h
builtin$(OBJ_EXT): handy.h
builtin$(OBJ_EXT): hv.h
builtin$(OBJ_EXT): hv_func.h
builtin$(OBJ_EXT): hv_macro.h
builtin$(OBJ_EXT): inline.h
builtin$(OBJ_EXT): intrpvar.h
builtin$(OBJ_EXT): iperlsys.h
builtin$(OBJ_EXT): locale_table.h
builtin$(OBJ_EXT): mg.h
builtin$(OBJ_EXT): mg_vtable.h
builtin$(OBJ_EXT): mydtrace.h
builtin$(OBJ_EXT): nostdio.h
builtin$(OBJ_EXT): op.h
builtin$(OBJ_EXT): op_reg_common.h
builtin$(OBJ_EXT): opcode.h
builtin$(OBJ_EXT): opnames.h
builtin$(OBJ_EXT): overload.h
builtin$(OBJ_EXT): pad.h
builtin$(OBJ_EXT): parser.h
builtin$(OBJ_EXT): patchlevel.h
builtin$(OBJ_EXT): perl.h
builtin$(OBJ_EXT): perl_langinfo.h
builtin$(OBJ_EXT): perl_siphash.h
builtin$(OBJ_EXT): perlio.h
builtin$(OBJ_EXT): perlstatic.h
builtin$(OBJ_EXT): perlvars.h
builtin$(OBJ_EXT): perly.h
builtin$(OBJ_EXT): pp.h
builtin$(OBJ_EXT): pp_proto.h
builtin$(OBJ_EXT): proto.h
builtin$(OBJ_EXT): regcharclass.h
builtin$(OBJ_EXT): regexp.h
builtin$(OBJ_EXT): sbox32_hash.h
builtin$(OBJ_EXT): scope.h
builtin$(OBJ_EXT): scope_types.h
builtin$(OBJ_EXT): sv.h
builtin$(OBJ_EXT): sv_inline.h
builtin$(OBJ_EXT): thread.h
builtin$(OBJ_EXT): unicode_constants.h
builtin$(OBJ_EXT): unixish.h
builtin$(OBJ_EXT): utf8.h
builtin$(OBJ_EXT): util.h
builtin$(OBJ_EXT): warnings.h
builtin$(OBJ_EXT): zaphod32_hash.h
builtin$(OBJ_EXT): cflags
caretx$(OBJ_EXT): CROSS_ROOT/include/alloca.h
caretx$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
caretx$(OBJ_EXT): CROSS_ROOT/include/assert.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
caretx$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
caretx$(OBJ_EXT): CROSS_ROOT/include/ctype.h
caretx$(OBJ_EXT): CROSS_ROOT/include/dirent.h
caretx$(OBJ_EXT): CROSS_ROOT/include/endian.h
caretx$(OBJ_EXT): CROSS_ROOT/include/errno.h
caretx$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
caretx$(OBJ_EXT): CROSS_ROOT/include/features.h
caretx$(OBJ_EXT): CROSS_ROOT/include/float.h
caretx$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
caretx$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
caretx$(OBJ_EXT): CROSS_ROOT/include/limits.h
caretx$(OBJ_EXT): CROSS_ROOT/include/locale.h
caretx$(OBJ_EXT): CROSS_ROOT/include/math.h
caretx$(OBJ_EXT): CROSS_ROOT/include/netdb.h
caretx$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
caretx$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
caretx$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
caretx$(OBJ_EXT): CROSS_ROOT/include/signal.h
caretx$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
caretx$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
caretx$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
caretx$(OBJ_EXT): CROSS_ROOT/include/stddef.h
caretx$(OBJ_EXT): CROSS_ROOT/include/stdint.h
caretx$(OBJ_EXT): CROSS_ROOT/include/stdio.h
caretx$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
caretx$(OBJ_EXT): CROSS_ROOT/include/string.h
caretx$(OBJ_EXT): CROSS_ROOT/include/strings.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
caretx$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
caretx$(OBJ_EXT): CROSS_ROOT/include/time.h
caretx$(OBJ_EXT): CROSS_ROOT/include/unistd.h
caretx$(OBJ_EXT): CROSS_ROOT/include/wchar.h
caretx$(OBJ_EXT): EXTERN.h
caretx$(OBJ_EXT): XSUB.h
caretx$(OBJ_EXT): av.h
caretx$(OBJ_EXT): caretx.c
caretx$(OBJ_EXT): charclass_invlists.h
caretx$(OBJ_EXT): config.h
caretx$(OBJ_EXT): cop.h
caretx$(OBJ_EXT): cv.h
caretx$(OBJ_EXT): embed.h
caretx$(OBJ_EXT): embedvar.h
caretx$(OBJ_EXT): form.h
caretx$(OBJ_EXT): gv.h
caretx$(OBJ_EXT): handy.h
caretx$(OBJ_EXT): hv.h
caretx$(OBJ_EXT): hv_func.h
caretx$(OBJ_EXT): hv_macro.h
caretx$(OBJ_EXT): inline.h
caretx$(OBJ_EXT): intrpvar.h
caretx$(OBJ_EXT): iperlsys.h
caretx$(OBJ_EXT): locale_table.h
caretx$(OBJ_EXT): mg.h
caretx$(OBJ_EXT): mg_vtable.h
caretx$(OBJ_EXT): mydtrace.h
caretx$(OBJ_EXT): nostdio.h
caretx$(OBJ_EXT): op.h
caretx$(OBJ_EXT): op_reg_common.h
caretx$(OBJ_EXT): opcode.h
caretx$(OBJ_EXT): opnames.h
caretx$(OBJ_EXT): overload.h
caretx$(OBJ_EXT): pad.h
caretx$(OBJ_EXT): parser.h
caretx$(OBJ_EXT): patchlevel.h
caretx$(OBJ_EXT): perl.h
caretx$(OBJ_EXT): perl_langinfo.h
caretx$(OBJ_EXT): perl_siphash.h
caretx$(OBJ_EXT): perlio.h
caretx$(OBJ_EXT): perlstatic.h
caretx$(OBJ_EXT): perlvars.h
caretx$(OBJ_EXT): perly.h
caretx$(OBJ_EXT): pp.h
caretx$(OBJ_EXT): pp_proto.h
caretx$(OBJ_EXT): proto.h
caretx$(OBJ_EXT): regcharclass.h
caretx$(OBJ_EXT): regexp.h
caretx$(OBJ_EXT): sbox32_hash.h
caretx$(OBJ_EXT): scope.h
caretx$(OBJ_EXT): scope_types.h
caretx$(OBJ_EXT): sv.h
caretx$(OBJ_EXT): sv_inline.h
caretx$(OBJ_EXT): thread.h
caretx$(OBJ_EXT): unicode_constants.h
caretx$(OBJ_EXT): unixish.h
caretx$(OBJ_EXT): utf8.h
caretx$(OBJ_EXT): util.h
caretx$(OBJ_EXT): warnings.h
caretx$(OBJ_EXT): zaphod32_hash.h
caretx$(OBJ_EXT): cflags
class$(OBJ_EXT): CROSS_ROOT/include/alloca.h
class$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
class$(OBJ_EXT): CROSS_ROOT/include/assert.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
class$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
class$(OBJ_EXT): CROSS_ROOT/include/ctype.h
class$(OBJ_EXT): CROSS_ROOT/include/dirent.h
class$(OBJ_EXT): CROSS_ROOT/include/endian.h
class$(OBJ_EXT): CROSS_ROOT/include/errno.h
class$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
class$(OBJ_EXT): CROSS_ROOT/include/features.h
class$(OBJ_EXT): CROSS_ROOT/include/float.h
class$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
class$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
class$(OBJ_EXT): CROSS_ROOT/include/limits.h
class$(OBJ_EXT): CROSS_ROOT/include/locale.h
class$(OBJ_EXT): CROSS_ROOT/include/math.h
class$(OBJ_EXT): CROSS_ROOT/include/netdb.h
class$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
class$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
class$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
class$(OBJ_EXT): CROSS_ROOT/include/signal.h
class$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
class$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
class$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
class$(OBJ_EXT): CROSS_ROOT/include/stddef.h
class$(OBJ_EXT): CROSS_ROOT/include/stdint.h
class$(OBJ_EXT): CROSS_ROOT/include/stdio.h
class$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
class$(OBJ_EXT): CROSS_ROOT/include/string.h
class$(OBJ_EXT): CROSS_ROOT/include/strings.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
class$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
class$(OBJ_EXT): CROSS_ROOT/include/time.h
class$(OBJ_EXT): CROSS_ROOT/include/unistd.h
class$(OBJ_EXT): CROSS_ROOT/include/wchar.h
class$(OBJ_EXT): EXTERN.h
class$(OBJ_EXT): XSUB.h
class$(OBJ_EXT): av.h
class$(OBJ_EXT): charclass_invlists.h
class$(OBJ_EXT): class.c
class$(OBJ_EXT): config.h
class$(OBJ_EXT): cop.h
class$(OBJ_EXT): cv.h
class$(OBJ_EXT): embed.h
class$(OBJ_EXT): embedvar.h
class$(OBJ_EXT): form.h
class$(OBJ_EXT): gv.h
class$(OBJ_EXT): handy.h
class$(OBJ_EXT): hv.h
class$(OBJ_EXT): hv_func.h
class$(OBJ_EXT): hv_macro.h
class$(OBJ_EXT): inline.h
class$(OBJ_EXT): intrpvar.h
class$(OBJ_EXT): iperlsys.h
class$(OBJ_EXT): locale_table.h
class$(OBJ_EXT): mg.h
class$(OBJ_EXT): mg_vtable.h
class$(OBJ_EXT): mydtrace.h
class$(OBJ_EXT): nostdio.h
class$(OBJ_EXT): op.h
class$(OBJ_EXT): op_reg_common.h
class$(OBJ_EXT): opcode.h
class$(OBJ_EXT): opnames.h
class$(OBJ_EXT): overload.h
class$(OBJ_EXT): pad.h
class$(OBJ_EXT): parser.h
class$(OBJ_EXT): patchlevel.h
class$(OBJ_EXT): perl.h
class$(OBJ_EXT): perl_langinfo.h
class$(OBJ_EXT): perl_siphash.h
class$(OBJ_EXT): perlio.h
class$(OBJ_EXT): perlstatic.h
class$(OBJ_EXT): perlvars.h
class$(OBJ_EXT): perly.h
class$(OBJ_EXT): pp.h
class$(OBJ_EXT): pp_proto.h
class$(OBJ_EXT): proto.h
class$(OBJ_EXT): regcharclass.h
class$(OBJ_EXT): regexp.h
class$(OBJ_EXT): sbox32_hash.h
class$(OBJ_EXT): scope.h
class$(OBJ_EXT): scope_types.h
class$(OBJ_EXT): sv.h
class$(OBJ_EXT): sv_inline.h
class$(OBJ_EXT): thread.h
class$(OBJ_EXT): unicode_constants.h
class$(OBJ_EXT): unixish.h
class$(OBJ_EXT): utf8.h
class$(OBJ_EXT): util.h
class$(OBJ_EXT): warnings.h
class$(OBJ_EXT): zaphod32_hash.h
class$(OBJ_EXT): cflags
deb$(OBJ_EXT): CROSS_ROOT/include/alloca.h
deb$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
deb$(OBJ_EXT): CROSS_ROOT/include/assert.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
deb$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
deb$(OBJ_EXT): CROSS_ROOT/include/ctype.h
deb$(OBJ_EXT): CROSS_ROOT/include/dirent.h
deb$(OBJ_EXT): CROSS_ROOT/include/endian.h
deb$(OBJ_EXT): CROSS_ROOT/include/errno.h
deb$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
deb$(OBJ_EXT): CROSS_ROOT/include/features.h
deb$(OBJ_EXT): CROSS_ROOT/include/float.h
deb$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
deb$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
deb$(OBJ_EXT): CROSS_ROOT/include/limits.h
deb$(OBJ_EXT): CROSS_ROOT/include/locale.h
deb$(OBJ_EXT): CROSS_ROOT/include/math.h
deb$(OBJ_EXT): CROSS_ROOT/include/netdb.h
deb$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
deb$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
deb$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
deb$(OBJ_EXT): CROSS_ROOT/include/signal.h
deb$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
deb$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
deb$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
deb$(OBJ_EXT): CROSS_ROOT/include/stddef.h
deb$(OBJ_EXT): CROSS_ROOT/include/stdint.h
deb$(OBJ_EXT): CROSS_ROOT/include/stdio.h
deb$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
deb$(OBJ_EXT): CROSS_ROOT/include/string.h
deb$(OBJ_EXT): CROSS_ROOT/include/strings.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
deb$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
deb$(OBJ_EXT): CROSS_ROOT/include/time.h
deb$(OBJ_EXT): CROSS_ROOT/include/unistd.h
deb$(OBJ_EXT): CROSS_ROOT/include/wchar.h
deb$(OBJ_EXT): EXTERN.h
deb$(OBJ_EXT): av.h
deb$(OBJ_EXT): charclass_invlists.h
deb$(OBJ_EXT): config.h
deb$(OBJ_EXT): cop.h
deb$(OBJ_EXT): cv.h
deb$(OBJ_EXT): deb.c
deb$(OBJ_EXT): embed.h
deb$(OBJ_EXT): embedvar.h
deb$(OBJ_EXT): form.h
deb$(OBJ_EXT): gv.h
deb$(OBJ_EXT): handy.h
deb$(OBJ_EXT): hv.h
deb$(OBJ_EXT): hv_func.h
deb$(OBJ_EXT): hv_macro.h
deb$(OBJ_EXT): inline.h
deb$(OBJ_EXT): intrpvar.h
deb$(OBJ_EXT): iperlsys.h
deb$(OBJ_EXT): locale_table.h
deb$(OBJ_EXT): mg.h
deb$(OBJ_EXT): mg_vtable.h
deb$(OBJ_EXT): mydtrace.h
deb$(OBJ_EXT): nostdio.h
deb$(OBJ_EXT): op.h
deb$(OBJ_EXT): op_reg_common.h
deb$(OBJ_EXT): opcode.h
deb$(OBJ_EXT): opnames.h
deb$(OBJ_EXT): overload.h
deb$(OBJ_EXT): pad.h
deb$(OBJ_EXT): parser.h
deb$(OBJ_EXT): patchlevel.h
deb$(OBJ_EXT): perl.h
deb$(OBJ_EXT): perl_langinfo.h
deb$(OBJ_EXT): perl_siphash.h
deb$(OBJ_EXT): perlio.h
deb$(OBJ_EXT): perlstatic.h
deb$(OBJ_EXT): perlvars.h
deb$(OBJ_EXT): perly.h
deb$(OBJ_EXT): pp.h
deb$(OBJ_EXT): pp_proto.h
deb$(OBJ_EXT): proto.h
deb$(OBJ_EXT): regcharclass.h
deb$(OBJ_EXT): regexp.h
deb$(OBJ_EXT): sbox32_hash.h
deb$(OBJ_EXT): scope.h
deb$(OBJ_EXT): scope_types.h
deb$(OBJ_EXT): sv.h
deb$(OBJ_EXT): sv_inline.h
deb$(OBJ_EXT): thread.h
deb$(OBJ_EXT): unicode_constants.h
deb$(OBJ_EXT): unixish.h
deb$(OBJ_EXT): utf8.h
deb$(OBJ_EXT): util.h
deb$(OBJ_EXT): warnings.h
deb$(OBJ_EXT): zaphod32_hash.h
deb$(OBJ_EXT): cflags
doio$(OBJ_EXT): CROSS_ROOT/include/alloca.h
doio$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
doio$(OBJ_EXT): CROSS_ROOT/include/assert.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/msg.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/shm.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
doio$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
doio$(OBJ_EXT): CROSS_ROOT/include/ctype.h
doio$(OBJ_EXT): CROSS_ROOT/include/dirent.h
doio$(OBJ_EXT): CROSS_ROOT/include/endian.h
doio$(OBJ_EXT): CROSS_ROOT/include/errno.h
doio$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
doio$(OBJ_EXT): CROSS_ROOT/include/features.h
doio$(OBJ_EXT): CROSS_ROOT/include/float.h
doio$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
doio$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
doio$(OBJ_EXT): CROSS_ROOT/include/limits.h
doio$(OBJ_EXT): CROSS_ROOT/include/locale.h
doio$(OBJ_EXT): CROSS_ROOT/include/math.h
doio$(OBJ_EXT): CROSS_ROOT/include/netdb.h
doio$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
doio$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
doio$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
doio$(OBJ_EXT): CROSS_ROOT/include/signal.h
doio$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
doio$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
doio$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
doio$(OBJ_EXT): CROSS_ROOT/include/stddef.h
doio$(OBJ_EXT): CROSS_ROOT/include/stdint.h
doio$(OBJ_EXT): CROSS_ROOT/include/stdio.h
doio$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
doio$(OBJ_EXT): CROSS_ROOT/include/string.h
doio$(OBJ_EXT): CROSS_ROOT/include/strings.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/msg.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/shm.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
doio$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
doio$(OBJ_EXT): CROSS_ROOT/include/time.h
doio$(OBJ_EXT): CROSS_ROOT/include/unistd.h
doio$(OBJ_EXT): CROSS_ROOT/include/utime.h
doio$(OBJ_EXT): CROSS_ROOT/include/wchar.h
doio$(OBJ_EXT): EXTERN.h
doio$(OBJ_EXT): av.h
doio$(OBJ_EXT): charclass_invlists.h
doio$(OBJ_EXT): config.h
doio$(OBJ_EXT): cop.h
doio$(OBJ_EXT): cv.h
doio$(OBJ_EXT): doio.c
doio$(OBJ_EXT): embed.h
doio$(OBJ_EXT): embedvar.h
doio$(OBJ_EXT): form.h
doio$(OBJ_EXT): gv.h
doio$(OBJ_EXT): handy.h
doio$(OBJ_EXT): hv.h
doio$(OBJ_EXT): hv_func.h
doio$(OBJ_EXT): hv_macro.h
doio$(OBJ_EXT): inline.h
doio$(OBJ_EXT): intrpvar.h
doio$(OBJ_EXT): iperlsys.h
doio$(OBJ_EXT): locale_table.h
doio$(OBJ_EXT): mg.h
doio$(OBJ_EXT): mg_vtable.h
doio$(OBJ_EXT): mydtrace.h
doio$(OBJ_EXT): nostdio.h
doio$(OBJ_EXT): op.h
doio$(OBJ_EXT): op_reg_common.h
doio$(OBJ_EXT): opcode.h
doio$(OBJ_EXT): opnames.h
doio$(OBJ_EXT): overload.h
doio$(OBJ_EXT): pad.h
doio$(OBJ_EXT): parser.h
doio$(OBJ_EXT): patchlevel.h
doio$(OBJ_EXT): perl.h
doio$(OBJ_EXT): perl_langinfo.h
doio$(OBJ_EXT): perl_siphash.h
doio$(OBJ_EXT): perlio.h
doio$(OBJ_EXT): perlstatic.h
doio$(OBJ_EXT): perlvars.h
doio$(OBJ_EXT): perly.h
doio$(OBJ_EXT): pp.h
doio$(OBJ_EXT): pp_proto.h
doio$(OBJ_EXT): proto.h
doio$(OBJ_EXT): regcharclass.h
doio$(OBJ_EXT): regexp.h
doio$(OBJ_EXT): sbox32_hash.h
doio$(OBJ_EXT): scope.h
doio$(OBJ_EXT): scope_types.h
doio$(OBJ_EXT): sv.h
doio$(OBJ_EXT): sv_inline.h
doio$(OBJ_EXT): thread.h
doio$(OBJ_EXT): unicode_constants.h
doio$(OBJ_EXT): unixish.h
doio$(OBJ_EXT): utf8.h
doio$(OBJ_EXT): util.h
doio$(OBJ_EXT): warnings.h
doio$(OBJ_EXT): zaphod32_hash.h
doio$(OBJ_EXT): cflags
doop$(OBJ_EXT): CROSS_ROOT/include/alloca.h
doop$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
doop$(OBJ_EXT): CROSS_ROOT/include/assert.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
doop$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
doop$(OBJ_EXT): CROSS_ROOT/include/ctype.h
doop$(OBJ_EXT): CROSS_ROOT/include/dirent.h
doop$(OBJ_EXT): CROSS_ROOT/include/endian.h
doop$(OBJ_EXT): CROSS_ROOT/include/errno.h
doop$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
doop$(OBJ_EXT): CROSS_ROOT/include/features.h
doop$(OBJ_EXT): CROSS_ROOT/include/float.h
doop$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
doop$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
doop$(OBJ_EXT): CROSS_ROOT/include/limits.h
doop$(OBJ_EXT): CROSS_ROOT/include/locale.h
doop$(OBJ_EXT): CROSS_ROOT/include/math.h
doop$(OBJ_EXT): CROSS_ROOT/include/netdb.h
doop$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
doop$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
doop$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
doop$(OBJ_EXT): CROSS_ROOT/include/signal.h
doop$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
doop$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
doop$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
doop$(OBJ_EXT): CROSS_ROOT/include/stddef.h
doop$(OBJ_EXT): CROSS_ROOT/include/stdint.h
doop$(OBJ_EXT): CROSS_ROOT/include/stdio.h
doop$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
doop$(OBJ_EXT): CROSS_ROOT/include/string.h
doop$(OBJ_EXT): CROSS_ROOT/include/strings.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
doop$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
doop$(OBJ_EXT): CROSS_ROOT/include/time.h
doop$(OBJ_EXT): CROSS_ROOT/include/unistd.h
doop$(OBJ_EXT): CROSS_ROOT/include/wchar.h
doop$(OBJ_EXT): EXTERN.h
doop$(OBJ_EXT): av.h
doop$(OBJ_EXT): charclass_invlists.h
doop$(OBJ_EXT): config.h
doop$(OBJ_EXT): cop.h
doop$(OBJ_EXT): cv.h
doop$(OBJ_EXT): doop.c
doop$(OBJ_EXT): embed.h
doop$(OBJ_EXT): embedvar.h
doop$(OBJ_EXT): form.h
doop$(OBJ_EXT): gv.h
doop$(OBJ_EXT): handy.h
doop$(OBJ_EXT): hv.h
doop$(OBJ_EXT): hv_func.h
doop$(OBJ_EXT): hv_macro.h
doop$(OBJ_EXT): inline.h
doop$(OBJ_EXT): intrpvar.h
doop$(OBJ_EXT): invlist_inline.h
doop$(OBJ_EXT): iperlsys.h
doop$(OBJ_EXT): locale_table.h
doop$(OBJ_EXT): mg.h
doop$(OBJ_EXT): mg_vtable.h
doop$(OBJ_EXT): mydtrace.h
doop$(OBJ_EXT): nostdio.h
doop$(OBJ_EXT): op.h
doop$(OBJ_EXT): op_reg_common.h
doop$(OBJ_EXT): opcode.h
doop$(OBJ_EXT): opnames.h
doop$(OBJ_EXT): overload.h
doop$(OBJ_EXT): pad.h
doop$(OBJ_EXT): parser.h
doop$(OBJ_EXT): patchlevel.h
doop$(OBJ_EXT): perl.h
doop$(OBJ_EXT): perl_langinfo.h
doop$(OBJ_EXT): perl_siphash.h
doop$(OBJ_EXT): perlio.h
doop$(OBJ_EXT): perlstatic.h
doop$(OBJ_EXT): perlvars.h
doop$(OBJ_EXT): perly.h
doop$(OBJ_EXT): pp.h
doop$(OBJ_EXT): pp_proto.h
doop$(OBJ_EXT): proto.h
doop$(OBJ_EXT): regcharclass.h
doop$(OBJ_EXT): regexp.h
doop$(OBJ_EXT): sbox32_hash.h
doop$(OBJ_EXT): scope.h
doop$(OBJ_EXT): scope_types.h
doop$(OBJ_EXT): sv.h
doop$(OBJ_EXT): sv_inline.h
doop$(OBJ_EXT): thread.h
doop$(OBJ_EXT): unicode_constants.h
doop$(OBJ_EXT): unixish.h
doop$(OBJ_EXT): utf8.h
doop$(OBJ_EXT): util.h
doop$(OBJ_EXT): warnings.h
doop$(OBJ_EXT): zaphod32_hash.h
doop$(OBJ_EXT): cflags
dquote$(OBJ_EXT): CROSS_ROOT/include/alloca.h
dquote$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
dquote$(OBJ_EXT): CROSS_ROOT/include/assert.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
dquote$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
dquote$(OBJ_EXT): CROSS_ROOT/include/ctype.h
dquote$(OBJ_EXT): CROSS_ROOT/include/dirent.h
dquote$(OBJ_EXT): CROSS_ROOT/include/endian.h
dquote$(OBJ_EXT): CROSS_ROOT/include/errno.h
dquote$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
dquote$(OBJ_EXT): CROSS_ROOT/include/features.h
dquote$(OBJ_EXT): CROSS_ROOT/include/float.h
dquote$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
dquote$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
dquote$(OBJ_EXT): CROSS_ROOT/include/limits.h
dquote$(OBJ_EXT): CROSS_ROOT/include/locale.h
dquote$(OBJ_EXT): CROSS_ROOT/include/math.h
dquote$(OBJ_EXT): CROSS_ROOT/include/netdb.h
dquote$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
dquote$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
dquote$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
dquote$(OBJ_EXT): CROSS_ROOT/include/signal.h
dquote$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
dquote$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
dquote$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
dquote$(OBJ_EXT): CROSS_ROOT/include/stddef.h
dquote$(OBJ_EXT): CROSS_ROOT/include/stdint.h
dquote$(OBJ_EXT): CROSS_ROOT/include/stdio.h
dquote$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
dquote$(OBJ_EXT): CROSS_ROOT/include/string.h
dquote$(OBJ_EXT): CROSS_ROOT/include/strings.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
dquote$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
dquote$(OBJ_EXT): CROSS_ROOT/include/time.h
dquote$(OBJ_EXT): CROSS_ROOT/include/unistd.h
dquote$(OBJ_EXT): CROSS_ROOT/include/wchar.h
dquote$(OBJ_EXT): EXTERN.h
dquote$(OBJ_EXT): av.h
dquote$(OBJ_EXT): charclass_invlists.h
dquote$(OBJ_EXT): config.h
dquote$(OBJ_EXT): cop.h
dquote$(OBJ_EXT): cv.h
dquote$(OBJ_EXT): dquote.c
dquote$(OBJ_EXT): embed.h
dquote$(OBJ_EXT): embedvar.h
dquote$(OBJ_EXT): form.h
dquote$(OBJ_EXT): gv.h
dquote$(OBJ_EXT): handy.h
dquote$(OBJ_EXT): hv.h
dquote$(OBJ_EXT): hv_func.h
dquote$(OBJ_EXT): hv_macro.h
dquote$(OBJ_EXT): inline.h
dquote$(OBJ_EXT): intrpvar.h
dquote$(OBJ_EXT): iperlsys.h
dquote$(OBJ_EXT): locale_table.h
dquote$(OBJ_EXT): mg.h
dquote$(OBJ_EXT): mg_vtable.h
dquote$(OBJ_EXT): mydtrace.h
dquote$(OBJ_EXT): nostdio.h
dquote$(OBJ_EXT): op.h
dquote$(OBJ_EXT): op_reg_common.h
dquote$(OBJ_EXT): opcode.h
dquote$(OBJ_EXT): opnames.h
dquote$(OBJ_EXT): overload.h
dquote$(OBJ_EXT): pad.h
dquote$(OBJ_EXT): parser.h
dquote$(OBJ_EXT): patchlevel.h
dquote$(OBJ_EXT): perl.h
dquote$(OBJ_EXT): perl_langinfo.h
dquote$(OBJ_EXT): perl_siphash.h
dquote$(OBJ_EXT): perlio.h
dquote$(OBJ_EXT): perlstatic.h
dquote$(OBJ_EXT): perlvars.h
dquote$(OBJ_EXT): perly.h
dquote$(OBJ_EXT): pp.h
dquote$(OBJ_EXT): pp_proto.h
dquote$(OBJ_EXT): proto.h
dquote$(OBJ_EXT): regcharclass.h
dquote$(OBJ_EXT): regexp.h
dquote$(OBJ_EXT): sbox32_hash.h
dquote$(OBJ_EXT): scope.h
dquote$(OBJ_EXT): scope_types.h
dquote$(OBJ_EXT): sv.h
dquote$(OBJ_EXT): sv_inline.h
dquote$(OBJ_EXT): thread.h
dquote$(OBJ_EXT): unicode_constants.h
dquote$(OBJ_EXT): unixish.h
dquote$(OBJ_EXT): utf8.h
dquote$(OBJ_EXT): util.h
dquote$(OBJ_EXT): warnings.h
dquote$(OBJ_EXT): zaphod32_hash.h
dquote$(OBJ_EXT): cflags
dump$(OBJ_EXT): CROSS_ROOT/include/alloca.h
dump$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
dump$(OBJ_EXT): CROSS_ROOT/include/assert.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
dump$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
dump$(OBJ_EXT): CROSS_ROOT/include/ctype.h
dump$(OBJ_EXT): CROSS_ROOT/include/dirent.h
dump$(OBJ_EXT): CROSS_ROOT/include/endian.h
dump$(OBJ_EXT): CROSS_ROOT/include/errno.h
dump$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
dump$(OBJ_EXT): CROSS_ROOT/include/features.h
dump$(OBJ_EXT): CROSS_ROOT/include/float.h
dump$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
dump$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
dump$(OBJ_EXT): CROSS_ROOT/include/limits.h
dump$(OBJ_EXT): CROSS_ROOT/include/locale.h
dump$(OBJ_EXT): CROSS_ROOT/include/math.h
dump$(OBJ_EXT): CROSS_ROOT/include/netdb.h
dump$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
dump$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
dump$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
dump$(OBJ_EXT): CROSS_ROOT/include/signal.h
dump$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
dump$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
dump$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
dump$(OBJ_EXT): CROSS_ROOT/include/stddef.h
dump$(OBJ_EXT): CROSS_ROOT/include/stdint.h
dump$(OBJ_EXT): CROSS_ROOT/include/stdio.h
dump$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
dump$(OBJ_EXT): CROSS_ROOT/include/string.h
dump$(OBJ_EXT): CROSS_ROOT/include/strings.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
dump$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
dump$(OBJ_EXT): CROSS_ROOT/include/time.h
dump$(OBJ_EXT): CROSS_ROOT/include/unistd.h
dump$(OBJ_EXT): CROSS_ROOT/include/wchar.h
dump$(OBJ_EXT): EXTERN.h
dump$(OBJ_EXT): av.h
dump$(OBJ_EXT): charclass_invlists.h
dump$(OBJ_EXT): config.h
dump$(OBJ_EXT): cop.h
dump$(OBJ_EXT): cv.h
dump$(OBJ_EXT): dump.c
dump$(OBJ_EXT): embed.h
dump$(OBJ_EXT): embedvar.h
dump$(OBJ_EXT): form.h
dump$(OBJ_EXT): gv.h
dump$(OBJ_EXT): handy.h
dump$(OBJ_EXT): hv.h
dump$(OBJ_EXT): hv_func.h
dump$(OBJ_EXT): hv_macro.h
dump$(OBJ_EXT): inline.h
dump$(OBJ_EXT): intrpvar.h
dump$(OBJ_EXT): iperlsys.h
dump$(OBJ_EXT): locale_table.h
dump$(OBJ_EXT): mg.h
dump$(OBJ_EXT): mg_names.inc
dump$(OBJ_EXT): mg_vtable.h
dump$(OBJ_EXT): mydtrace.h
dump$(OBJ_EXT): nostdio.h
dump$(OBJ_EXT): op.h
dump$(OBJ_EXT): op_reg_common.h
dump$(OBJ_EXT): opcode.h
dump$(OBJ_EXT): opnames.h
dump$(OBJ_EXT): overload.h
dump$(OBJ_EXT): pad.h
dump$(OBJ_EXT): parser.h
dump$(OBJ_EXT): patchlevel.h
dump$(OBJ_EXT): perl.h
dump$(OBJ_EXT): perl_langinfo.h
dump$(OBJ_EXT): perl_siphash.h
dump$(OBJ_EXT): perlio.h
dump$(OBJ_EXT): perlstatic.h
dump$(OBJ_EXT): perlvars.h
dump$(OBJ_EXT): perly.h
dump$(OBJ_EXT): pp.h
dump$(OBJ_EXT): pp_proto.h
dump$(OBJ_EXT): proto.h
dump$(OBJ_EXT): regcharclass.h
dump$(OBJ_EXT): regcomp.h
dump$(OBJ_EXT): regexp.h
dump$(OBJ_EXT): regnodes.h
dump$(OBJ_EXT): sbox32_hash.h
dump$(OBJ_EXT): scope.h
dump$(OBJ_EXT): scope_types.h
dump$(OBJ_EXT): sv.h
dump$(OBJ_EXT): sv_inline.h
dump$(OBJ_EXT): thread.h
dump$(OBJ_EXT): unicode_constants.h
dump$(OBJ_EXT): unixish.h
dump$(OBJ_EXT): utf8.h
dump$(OBJ_EXT): util.h
dump$(OBJ_EXT): warnings.h
dump$(OBJ_EXT): zaphod32_hash.h
dump$(OBJ_EXT): cflags
globals$(OBJ_EXT): CROSS_ROOT/include/alloca.h
globals$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
globals$(OBJ_EXT): CROSS_ROOT/include/assert.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
globals$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
globals$(OBJ_EXT): CROSS_ROOT/include/ctype.h
globals$(OBJ_EXT): CROSS_ROOT/include/dirent.h
globals$(OBJ_EXT): CROSS_ROOT/include/endian.h
globals$(OBJ_EXT): CROSS_ROOT/include/errno.h
globals$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
globals$(OBJ_EXT): CROSS_ROOT/include/features.h
globals$(OBJ_EXT): CROSS_ROOT/include/float.h
globals$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
globals$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
globals$(OBJ_EXT): CROSS_ROOT/include/limits.h
globals$(OBJ_EXT): CROSS_ROOT/include/locale.h
globals$(OBJ_EXT): CROSS_ROOT/include/math.h
globals$(OBJ_EXT): CROSS_ROOT/include/netdb.h
globals$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
globals$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
globals$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
globals$(OBJ_EXT): CROSS_ROOT/include/signal.h
globals$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
globals$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
globals$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
globals$(OBJ_EXT): CROSS_ROOT/include/stddef.h
globals$(OBJ_EXT): CROSS_ROOT/include/stdint.h
globals$(OBJ_EXT): CROSS_ROOT/include/stdio.h
globals$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
globals$(OBJ_EXT): CROSS_ROOT/include/string.h
globals$(OBJ_EXT): CROSS_ROOT/include/strings.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
globals$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
globals$(OBJ_EXT): CROSS_ROOT/include/time.h
globals$(OBJ_EXT): CROSS_ROOT/include/unistd.h
globals$(OBJ_EXT): CROSS_ROOT/include/wchar.h
globals$(OBJ_EXT): INTERN.h
globals$(OBJ_EXT): av.h
globals$(OBJ_EXT): bitcount.h
globals$(OBJ_EXT): charclass_invlists.h
globals$(OBJ_EXT): config.h
globals$(OBJ_EXT): cop.h
globals$(OBJ_EXT): cv.h
globals$(OBJ_EXT): embed.h
globals$(OBJ_EXT): embedvar.h
globals$(OBJ_EXT): form.h
globals$(OBJ_EXT): globals.c
globals$(OBJ_EXT): gv.h
globals$(OBJ_EXT): handy.h
globals$(OBJ_EXT): hv.h
globals$(OBJ_EXT): hv_func.h
globals$(OBJ_EXT): hv_macro.h
globals$(OBJ_EXT): inline.h
globals$(OBJ_EXT): intrpvar.h
globals$(OBJ_EXT): iperlsys.h
globals$(OBJ_EXT): l1_char_class_tab.h
globals$(OBJ_EXT): locale_table.h
globals$(OBJ_EXT): mg.h
globals$(OBJ_EXT): mg_data.h
globals$(OBJ_EXT): mg_vtable.h
globals$(OBJ_EXT): mydtrace.h
globals$(OBJ_EXT): nostdio.h
globals$(OBJ_EXT): op.h
globals$(OBJ_EXT): op_reg_common.h
globals$(OBJ_EXT): opcode.h
globals$(OBJ_EXT): opnames.h
globals$(OBJ_EXT): overload.h
globals$(OBJ_EXT): pad.h
globals$(OBJ_EXT): parser.h
globals$(OBJ_EXT): patchlevel.h
globals$(OBJ_EXT): perl.h
globals$(OBJ_EXT): perl_langinfo.h
globals$(OBJ_EXT): perl_siphash.h
globals$(OBJ_EXT): perlio.h
globals$(OBJ_EXT): perlstatic.h
globals$(OBJ_EXT): perlvars.h
globals$(OBJ_EXT): perly.h
globals$(OBJ_EXT): pp.h
globals$(OBJ_EXT): pp_proto.h
globals$(OBJ_EXT): proto.h
globals$(OBJ_EXT): regcharclass.h
globals$(OBJ_EXT): regcomp.h
globals$(OBJ_EXT): regexp.h
globals$(OBJ_EXT): regnodes.h
globals$(OBJ_EXT): sbox32_hash.h
globals$(OBJ_EXT): scope.h
globals$(OBJ_EXT): scope_types.h
globals$(OBJ_EXT): sv.h
globals$(OBJ_EXT): sv_inline.h
globals$(OBJ_EXT): thread.h
globals$(OBJ_EXT): unicode_constants.h
globals$(OBJ_EXT): unixish.h
globals$(OBJ_EXT): utf8.h
globals$(OBJ_EXT): util.h
globals$(OBJ_EXT): uudmap.h
globals$(OBJ_EXT): warnings.h
globals$(OBJ_EXT): zaphod32_hash.h
globals$(OBJ_EXT): cflags
gv$(OBJ_EXT): CROSS_ROOT/include/alloca.h
gv$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
gv$(OBJ_EXT): CROSS_ROOT/include/assert.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
gv$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
gv$(OBJ_EXT): CROSS_ROOT/include/ctype.h
gv$(OBJ_EXT): CROSS_ROOT/include/dirent.h
gv$(OBJ_EXT): CROSS_ROOT/include/endian.h
gv$(OBJ_EXT): CROSS_ROOT/include/errno.h
gv$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
gv$(OBJ_EXT): CROSS_ROOT/include/features.h
gv$(OBJ_EXT): CROSS_ROOT/include/float.h
gv$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
gv$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
gv$(OBJ_EXT): CROSS_ROOT/include/limits.h
gv$(OBJ_EXT): CROSS_ROOT/include/locale.h
gv$(OBJ_EXT): CROSS_ROOT/include/math.h
gv$(OBJ_EXT): CROSS_ROOT/include/netdb.h
gv$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
gv$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
gv$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
gv$(OBJ_EXT): CROSS_ROOT/include/signal.h
gv$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
gv$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
gv$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
gv$(OBJ_EXT): CROSS_ROOT/include/stddef.h
gv$(OBJ_EXT): CROSS_ROOT/include/stdint.h
gv$(OBJ_EXT): CROSS_ROOT/include/stdio.h
gv$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
gv$(OBJ_EXT): CROSS_ROOT/include/string.h
gv$(OBJ_EXT): CROSS_ROOT/include/strings.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
gv$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
gv$(OBJ_EXT): CROSS_ROOT/include/time.h
gv$(OBJ_EXT): CROSS_ROOT/include/unistd.h
gv$(OBJ_EXT): CROSS_ROOT/include/wchar.h
gv$(OBJ_EXT): EXTERN.h
gv$(OBJ_EXT): XSUB.h
gv$(OBJ_EXT): av.h
gv$(OBJ_EXT): charclass_invlists.h
gv$(OBJ_EXT): config.h
gv$(OBJ_EXT): cop.h
gv$(OBJ_EXT): cv.h
gv$(OBJ_EXT): embed.h
gv$(OBJ_EXT): embedvar.h
gv$(OBJ_EXT): feature.h
gv$(OBJ_EXT): form.h
gv$(OBJ_EXT): gv.c
gv$(OBJ_EXT): gv.h
gv$(OBJ_EXT): handy.h
gv$(OBJ_EXT): hv.h
gv$(OBJ_EXT): hv_func.h
gv$(OBJ_EXT): hv_macro.h
gv$(OBJ_EXT): inline.h
gv$(OBJ_EXT): intrpvar.h
gv$(OBJ_EXT): iperlsys.h
gv$(OBJ_EXT): keywords.h
gv$(OBJ_EXT): locale_table.h
gv$(OBJ_EXT): mg.h
gv$(OBJ_EXT): mg_vtable.h
gv$(OBJ_EXT): mydtrace.h
gv$(OBJ_EXT): nostdio.h
gv$(OBJ_EXT): op.h
gv$(OBJ_EXT): op_reg_common.h
gv$(OBJ_EXT): opcode.h
gv$(OBJ_EXT): opnames.h
gv$(OBJ_EXT): overload.h
gv$(OBJ_EXT): overload.inc
gv$(OBJ_EXT): pad.h
gv$(OBJ_EXT): parser.h
gv$(OBJ_EXT): patchlevel.h
gv$(OBJ_EXT): perl.h
gv$(OBJ_EXT): perl_langinfo.h
gv$(OBJ_EXT): perl_siphash.h
gv$(OBJ_EXT): perlio.h
gv$(OBJ_EXT): perlstatic.h
gv$(OBJ_EXT): perlvars.h
gv$(OBJ_EXT): perly.h
gv$(OBJ_EXT): pp.h
gv$(OBJ_EXT): pp_proto.h
gv$(OBJ_EXT): proto.h
gv$(OBJ_EXT): regcharclass.h
gv$(OBJ_EXT): regexp.h
gv$(OBJ_EXT): sbox32_hash.h
gv$(OBJ_EXT): scope.h
gv$(OBJ_EXT): scope_types.h
gv$(OBJ_EXT): sv.h
gv$(OBJ_EXT): sv_inline.h
gv$(OBJ_EXT): thread.h
gv$(OBJ_EXT): unicode_constants.h
gv$(OBJ_EXT): unixish.h
gv$(OBJ_EXT): utf8.h
gv$(OBJ_EXT): util.h
gv$(OBJ_EXT): warnings.h
gv$(OBJ_EXT): zaphod32_hash.h
gv$(OBJ_EXT): cflags
hv$(OBJ_EXT): CROSS_ROOT/include/alloca.h
hv$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
hv$(OBJ_EXT): CROSS_ROOT/include/assert.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
hv$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
hv$(OBJ_EXT): CROSS_ROOT/include/ctype.h
hv$(OBJ_EXT): CROSS_ROOT/include/dirent.h
hv$(OBJ_EXT): CROSS_ROOT/include/endian.h
hv$(OBJ_EXT): CROSS_ROOT/include/errno.h
hv$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
hv$(OBJ_EXT): CROSS_ROOT/include/features.h
hv$(OBJ_EXT): CROSS_ROOT/include/float.h
hv$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
hv$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
hv$(OBJ_EXT): CROSS_ROOT/include/limits.h
hv$(OBJ_EXT): CROSS_ROOT/include/locale.h
hv$(OBJ_EXT): CROSS_ROOT/include/math.h
hv$(OBJ_EXT): CROSS_ROOT/include/netdb.h
hv$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
hv$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
hv$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
hv$(OBJ_EXT): CROSS_ROOT/include/signal.h
hv$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
hv$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
hv$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
hv$(OBJ_EXT): CROSS_ROOT/include/stddef.h
hv$(OBJ_EXT): CROSS_ROOT/include/stdint.h
hv$(OBJ_EXT): CROSS_ROOT/include/stdio.h
hv$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
hv$(OBJ_EXT): CROSS_ROOT/include/string.h
hv$(OBJ_EXT): CROSS_ROOT/include/strings.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
hv$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
hv$(OBJ_EXT): CROSS_ROOT/include/time.h
hv$(OBJ_EXT): CROSS_ROOT/include/unistd.h
hv$(OBJ_EXT): CROSS_ROOT/include/wchar.h
hv$(OBJ_EXT): EXTERN.h
hv$(OBJ_EXT): av.h
hv$(OBJ_EXT): charclass_invlists.h
hv$(OBJ_EXT): config.h
hv$(OBJ_EXT): cop.h
hv$(OBJ_EXT): cv.h
hv$(OBJ_EXT): embed.h
hv$(OBJ_EXT): embedvar.h
hv$(OBJ_EXT): form.h
hv$(OBJ_EXT): gv.h
hv$(OBJ_EXT): handy.h
hv$(OBJ_EXT): hv.c
hv$(OBJ_EXT): hv.h
hv$(OBJ_EXT): hv_func.h
hv$(OBJ_EXT): hv_macro.h
hv$(OBJ_EXT): inline.h
hv$(OBJ_EXT): intrpvar.h
hv$(OBJ_EXT): iperlsys.h
hv$(OBJ_EXT): locale_table.h
hv$(OBJ_EXT): mg.h
hv$(OBJ_EXT): mg_vtable.h
hv$(OBJ_EXT): mydtrace.h
hv$(OBJ_EXT): nostdio.h
hv$(OBJ_EXT): op.h
hv$(OBJ_EXT): op_reg_common.h
hv$(OBJ_EXT): opcode.h
hv$(OBJ_EXT): opnames.h
hv$(OBJ_EXT): overload.h
hv$(OBJ_EXT): pad.h
hv$(OBJ_EXT): parser.h
hv$(OBJ_EXT): patchlevel.h
hv$(OBJ_EXT): perl.h
hv$(OBJ_EXT): perl_langinfo.h
hv$(OBJ_EXT): perl_siphash.h
hv$(OBJ_EXT): perlio.h
hv$(OBJ_EXT): perlstatic.h
hv$(OBJ_EXT): perlvars.h
hv$(OBJ_EXT): perly.h
hv$(OBJ_EXT): pp.h
hv$(OBJ_EXT): pp_proto.h
hv$(OBJ_EXT): proto.h
hv$(OBJ_EXT): regcharclass.h
hv$(OBJ_EXT): regexp.h
hv$(OBJ_EXT): sbox32_hash.h
hv$(OBJ_EXT): scope.h
hv$(OBJ_EXT): scope_types.h
hv$(OBJ_EXT): sv.h
hv$(OBJ_EXT): sv_inline.h
hv$(OBJ_EXT): thread.h
hv$(OBJ_EXT): unicode_constants.h
hv$(OBJ_EXT): unixish.h
hv$(OBJ_EXT): utf8.h
hv$(OBJ_EXT): util.h
hv$(OBJ_EXT): warnings.h
hv$(OBJ_EXT): zaphod32_hash.h
hv$(OBJ_EXT): cflags
keywords$(OBJ_EXT): CROSS_ROOT/include/alloca.h
keywords$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
keywords$(OBJ_EXT): CROSS_ROOT/include/assert.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
keywords$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
keywords$(OBJ_EXT): CROSS_ROOT/include/ctype.h
keywords$(OBJ_EXT): CROSS_ROOT/include/dirent.h
keywords$(OBJ_EXT): CROSS_ROOT/include/endian.h
keywords$(OBJ_EXT): CROSS_ROOT/include/errno.h
keywords$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
keywords$(OBJ_EXT): CROSS_ROOT/include/features.h
keywords$(OBJ_EXT): CROSS_ROOT/include/float.h
keywords$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
keywords$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
keywords$(OBJ_EXT): CROSS_ROOT/include/limits.h
keywords$(OBJ_EXT): CROSS_ROOT/include/locale.h
keywords$(OBJ_EXT): CROSS_ROOT/include/math.h
keywords$(OBJ_EXT): CROSS_ROOT/include/netdb.h
keywords$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
keywords$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
keywords$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
keywords$(OBJ_EXT): CROSS_ROOT/include/signal.h
keywords$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
keywords$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
keywords$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
keywords$(OBJ_EXT): CROSS_ROOT/include/stddef.h
keywords$(OBJ_EXT): CROSS_ROOT/include/stdint.h
keywords$(OBJ_EXT): CROSS_ROOT/include/stdio.h
keywords$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
keywords$(OBJ_EXT): CROSS_ROOT/include/string.h
keywords$(OBJ_EXT): CROSS_ROOT/include/strings.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
keywords$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
keywords$(OBJ_EXT): CROSS_ROOT/include/time.h
keywords$(OBJ_EXT): CROSS_ROOT/include/unistd.h
keywords$(OBJ_EXT): CROSS_ROOT/include/wchar.h
keywords$(OBJ_EXT): EXTERN.h
keywords$(OBJ_EXT): av.h
keywords$(OBJ_EXT): charclass_invlists.h
keywords$(OBJ_EXT): config.h
keywords$(OBJ_EXT): cop.h
keywords$(OBJ_EXT): cv.h
keywords$(OBJ_EXT): embed.h
keywords$(OBJ_EXT): embedvar.h
keywords$(OBJ_EXT): feature.h
keywords$(OBJ_EXT): form.h
keywords$(OBJ_EXT): gv.h
keywords$(OBJ_EXT): handy.h
keywords$(OBJ_EXT): hv.h
keywords$(OBJ_EXT): hv_func.h
keywords$(OBJ_EXT): hv_macro.h
keywords$(OBJ_EXT): inline.h
keywords$(OBJ_EXT): intrpvar.h
keywords$(OBJ_EXT): iperlsys.h
keywords$(OBJ_EXT): keywords.c
keywords$(OBJ_EXT): keywords.h
keywords$(OBJ_EXT): locale_table.h
keywords$(OBJ_EXT): mg.h
keywords$(OBJ_EXT): mg_vtable.h
keywords$(OBJ_EXT): mydtrace.h
keywords$(OBJ_EXT): nostdio.h
keywords$(OBJ_EXT): op.h
keywords$(OBJ_EXT): op_reg_common.h
keywords$(OBJ_EXT): opcode.h
keywords$(OBJ_EXT): opnames.h
keywords$(OBJ_EXT): overload.h
keywords$(OBJ_EXT): pad.h
keywords$(OBJ_EXT): parser.h
keywords$(OBJ_EXT): patchlevel.h
keywords$(OBJ_EXT): perl.h
keywords$(OBJ_EXT): perl_langinfo.h
keywords$(OBJ_EXT): perl_siphash.h
keywords$(OBJ_EXT): perlio.h
keywords$(OBJ_EXT): perlstatic.h
keywords$(OBJ_EXT): perlvars.h
keywords$(OBJ_EXT): perly.h
keywords$(OBJ_EXT): pp.h
keywords$(OBJ_EXT): pp_proto.h
keywords$(OBJ_EXT): proto.h
keywords$(OBJ_EXT): regcharclass.h
keywords$(OBJ_EXT): regexp.h
keywords$(OBJ_EXT): sbox32_hash.h
keywords$(OBJ_EXT): scope.h
keywords$(OBJ_EXT): scope_types.h
keywords$(OBJ_EXT): sv.h
keywords$(OBJ_EXT): sv_inline.h
keywords$(OBJ_EXT): thread.h
keywords$(OBJ_EXT): unicode_constants.h
keywords$(OBJ_EXT): unixish.h
keywords$(OBJ_EXT): utf8.h
keywords$(OBJ_EXT): util.h
keywords$(OBJ_EXT): warnings.h
keywords$(OBJ_EXT): zaphod32_hash.h
keywords$(OBJ_EXT): cflags
locale$(OBJ_EXT): CROSS_ROOT/include/alloca.h
locale$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
locale$(OBJ_EXT): CROSS_ROOT/include/assert.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
locale$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
locale$(OBJ_EXT): CROSS_ROOT/include/ctype.h
locale$(OBJ_EXT): CROSS_ROOT/include/dirent.h
locale$(OBJ_EXT): CROSS_ROOT/include/endian.h
locale$(OBJ_EXT): CROSS_ROOT/include/errno.h
locale$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
locale$(OBJ_EXT): CROSS_ROOT/include/features.h
locale$(OBJ_EXT): CROSS_ROOT/include/float.h
locale$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
locale$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
locale$(OBJ_EXT): CROSS_ROOT/include/limits.h
locale$(OBJ_EXT): CROSS_ROOT/include/locale.h
locale$(OBJ_EXT): CROSS_ROOT/include/math.h
locale$(OBJ_EXT): CROSS_ROOT/include/netdb.h
locale$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
locale$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
locale$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
locale$(OBJ_EXT): CROSS_ROOT/include/signal.h
locale$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
locale$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
locale$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
locale$(OBJ_EXT): CROSS_ROOT/include/stddef.h
locale$(OBJ_EXT): CROSS_ROOT/include/stdint.h
locale$(OBJ_EXT): CROSS_ROOT/include/stdio.h
locale$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
locale$(OBJ_EXT): CROSS_ROOT/include/string.h
locale$(OBJ_EXT): CROSS_ROOT/include/strings.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
locale$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
locale$(OBJ_EXT): CROSS_ROOT/include/time.h
locale$(OBJ_EXT): CROSS_ROOT/include/unistd.h
locale$(OBJ_EXT): CROSS_ROOT/include/wchar.h
locale$(OBJ_EXT): CROSS_ROOT/include/wctype.h
locale$(OBJ_EXT): EXTERN.h
locale$(OBJ_EXT): av.h
locale$(OBJ_EXT): charclass_invlists.h
locale$(OBJ_EXT): config.h
locale$(OBJ_EXT): cop.h
locale$(OBJ_EXT): cv.h
locale$(OBJ_EXT): embed.h
locale$(OBJ_EXT): embedvar.h
locale$(OBJ_EXT): form.h
locale$(OBJ_EXT): gv.h
locale$(OBJ_EXT): handy.h
locale$(OBJ_EXT): hv.h
locale$(OBJ_EXT): hv_func.h
locale$(OBJ_EXT): hv_macro.h
locale$(OBJ_EXT): inline.h
locale$(OBJ_EXT): intrpvar.h
locale$(OBJ_EXT): iperlsys.h
locale$(OBJ_EXT): locale.c
locale$(OBJ_EXT): locale_table.h
locale$(OBJ_EXT): mg.h
locale$(OBJ_EXT): mg_vtable.h
locale$(OBJ_EXT): mydtrace.h
locale$(OBJ_EXT): nostdio.h
locale$(OBJ_EXT): op.h
locale$(OBJ_EXT): op_reg_common.h
locale$(OBJ_EXT): opcode.h
locale$(OBJ_EXT): opnames.h
locale$(OBJ_EXT): overload.h
locale$(OBJ_EXT): pad.h
locale$(OBJ_EXT): parser.h
locale$(OBJ_EXT): patchlevel.h
locale$(OBJ_EXT): perl.h
locale$(OBJ_EXT): perl_langinfo.h
locale$(OBJ_EXT): perl_siphash.h
locale$(OBJ_EXT): perlio.h
locale$(OBJ_EXT): perlstatic.h
locale$(OBJ_EXT): perlvars.h
locale$(OBJ_EXT): perly.h
locale$(OBJ_EXT): pp.h
locale$(OBJ_EXT): pp_proto.h
locale$(OBJ_EXT): proto.h
locale$(OBJ_EXT): reentr.h
locale$(OBJ_EXT): regcharclass.h
locale$(OBJ_EXT): regexp.h
locale$(OBJ_EXT): sbox32_hash.h
locale$(OBJ_EXT): scope.h
locale$(OBJ_EXT): scope_types.h
locale$(OBJ_EXT): sv.h
locale$(OBJ_EXT): sv_inline.h
locale$(OBJ_EXT): thread.h
locale$(OBJ_EXT): unicode_constants.h
locale$(OBJ_EXT): unixish.h
locale$(OBJ_EXT): utf8.h
locale$(OBJ_EXT): util.h
locale$(OBJ_EXT): warnings.h
locale$(OBJ_EXT): zaphod32_hash.h
locale$(OBJ_EXT): cflags
mathoms$(OBJ_EXT): CROSS_ROOT/include/alloca.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/assert.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/ctype.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/dirent.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/endian.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/errno.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/features.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/float.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/limits.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/locale.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/math.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/netdb.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/signal.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/stddef.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/stdint.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/stdio.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/string.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/strings.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/time.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/unistd.h
mathoms$(OBJ_EXT): CROSS_ROOT/include/wchar.h
mathoms$(OBJ_EXT): EXTERN.h
mathoms$(OBJ_EXT): av.h
mathoms$(OBJ_EXT): charclass_invlists.h
mathoms$(OBJ_EXT): config.h
mathoms$(OBJ_EXT): cop.h
mathoms$(OBJ_EXT): cv.h
mathoms$(OBJ_EXT): embed.h
mathoms$(OBJ_EXT): embedvar.h
mathoms$(OBJ_EXT): form.h
mathoms$(OBJ_EXT): gv.h
mathoms$(OBJ_EXT): handy.h
mathoms$(OBJ_EXT): hv.h
mathoms$(OBJ_EXT): hv_func.h
mathoms$(OBJ_EXT): hv_macro.h
mathoms$(OBJ_EXT): inline.h
mathoms$(OBJ_EXT): intrpvar.h
mathoms$(OBJ_EXT): iperlsys.h
mathoms$(OBJ_EXT): locale_table.h
mathoms$(OBJ_EXT): mathoms.c
mathoms$(OBJ_EXT): mg.h
mathoms$(OBJ_EXT): mg_vtable.h
mathoms$(OBJ_EXT): mydtrace.h
mathoms$(OBJ_EXT): nostdio.h
mathoms$(OBJ_EXT): op.h
mathoms$(OBJ_EXT): op_reg_common.h
mathoms$(OBJ_EXT): opcode.h
mathoms$(OBJ_EXT): opnames.h
mathoms$(OBJ_EXT): overload.h
mathoms$(OBJ_EXT): pad.h
mathoms$(OBJ_EXT): parser.h
mathoms$(OBJ_EXT): patchlevel.h
mathoms$(OBJ_EXT): perl.h
mathoms$(OBJ_EXT): perl_langinfo.h
mathoms$(OBJ_EXT): perl_siphash.h
mathoms$(OBJ_EXT): perlio.h
mathoms$(OBJ_EXT): perlstatic.h
mathoms$(OBJ_EXT): perlvars.h
mathoms$(OBJ_EXT): perly.h
mathoms$(OBJ_EXT): pp.h
mathoms$(OBJ_EXT): pp_proto.h
mathoms$(OBJ_EXT): proto.h
mathoms$(OBJ_EXT): regcharclass.h
mathoms$(OBJ_EXT): regexp.h
mathoms$(OBJ_EXT): sbox32_hash.h
mathoms$(OBJ_EXT): scope.h
mathoms$(OBJ_EXT): scope_types.h
mathoms$(OBJ_EXT): sv.h
mathoms$(OBJ_EXT): sv_inline.h
mathoms$(OBJ_EXT): thread.h
mathoms$(OBJ_EXT): unicode_constants.h
mathoms$(OBJ_EXT): unixish.h
mathoms$(OBJ_EXT): utf8.h
mathoms$(OBJ_EXT): util.h
mathoms$(OBJ_EXT): warnings.h
mathoms$(OBJ_EXT): zaphod32_hash.h
mathoms$(OBJ_EXT): cflags
mg$(OBJ_EXT): CROSS_ROOT/include/alloca.h
mg$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
mg$(OBJ_EXT): CROSS_ROOT/include/assert.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
mg$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
mg$(OBJ_EXT): CROSS_ROOT/include/ctype.h
mg$(OBJ_EXT): CROSS_ROOT/include/dirent.h
mg$(OBJ_EXT): CROSS_ROOT/include/endian.h
mg$(OBJ_EXT): CROSS_ROOT/include/errno.h
mg$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
mg$(OBJ_EXT): CROSS_ROOT/include/features.h
mg$(OBJ_EXT): CROSS_ROOT/include/float.h
mg$(OBJ_EXT): CROSS_ROOT/include/grp.h
mg$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
mg$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
mg$(OBJ_EXT): CROSS_ROOT/include/limits.h
mg$(OBJ_EXT): CROSS_ROOT/include/locale.h
mg$(OBJ_EXT): CROSS_ROOT/include/math.h
mg$(OBJ_EXT): CROSS_ROOT/include/netdb.h
mg$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
mg$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
mg$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
mg$(OBJ_EXT): CROSS_ROOT/include/signal.h
mg$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
mg$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
mg$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
mg$(OBJ_EXT): CROSS_ROOT/include/stddef.h
mg$(OBJ_EXT): CROSS_ROOT/include/stdint.h
mg$(OBJ_EXT): CROSS_ROOT/include/stdio.h
mg$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
mg$(OBJ_EXT): CROSS_ROOT/include/string.h
mg$(OBJ_EXT): CROSS_ROOT/include/strings.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/prctl.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
mg$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
mg$(OBJ_EXT): CROSS_ROOT/include/time.h
mg$(OBJ_EXT): CROSS_ROOT/include/unistd.h
mg$(OBJ_EXT): CROSS_ROOT/include/wchar.h
mg$(OBJ_EXT): EXTERN.h
mg$(OBJ_EXT): av.h
mg$(OBJ_EXT): charclass_invlists.h
mg$(OBJ_EXT): config.h
mg$(OBJ_EXT): cop.h
mg$(OBJ_EXT): cv.h
mg$(OBJ_EXT): embed.h
mg$(OBJ_EXT): embedvar.h
mg$(OBJ_EXT): feature.h
mg$(OBJ_EXT): form.h
mg$(OBJ_EXT): gv.h
mg$(OBJ_EXT): handy.h
mg$(OBJ_EXT): hv.h
mg$(OBJ_EXT): hv_func.h
mg$(OBJ_EXT): hv_macro.h
mg$(OBJ_EXT): inline.h
mg$(OBJ_EXT): intrpvar.h
mg$(OBJ_EXT): iperlsys.h
mg$(OBJ_EXT): locale_table.h
mg$(OBJ_EXT): mg.c
mg$(OBJ_EXT): mg.h
mg$(OBJ_EXT): mg_vtable.h
mg$(OBJ_EXT): mydtrace.h
mg$(OBJ_EXT): nostdio.h
mg$(OBJ_EXT): op.h
mg$(OBJ_EXT): op_reg_common.h
mg$(OBJ_EXT): opcode.h
mg$(OBJ_EXT): opnames.h
mg$(OBJ_EXT): overload.h
mg$(OBJ_EXT): pad.h
mg$(OBJ_EXT): parser.h
mg$(OBJ_EXT): patchlevel.h
mg$(OBJ_EXT): perl.h
mg$(OBJ_EXT): perl_langinfo.h
mg$(OBJ_EXT): perl_siphash.h
mg$(OBJ_EXT): perlio.h
mg$(OBJ_EXT): perlstatic.h
mg$(OBJ_EXT): perlvars.h
mg$(OBJ_EXT): perly.h
mg$(OBJ_EXT): pp.h
mg$(OBJ_EXT): pp_proto.h
mg$(OBJ_EXT): proto.h
mg$(OBJ_EXT): regcharclass.h
mg$(OBJ_EXT): regexp.h
mg$(OBJ_EXT): sbox32_hash.h
mg$(OBJ_EXT): scope.h
mg$(OBJ_EXT): scope_types.h
mg$(OBJ_EXT): sv.h
mg$(OBJ_EXT): sv_inline.h
mg$(OBJ_EXT): thread.h
mg$(OBJ_EXT): unicode_constants.h
mg$(OBJ_EXT): unixish.h
mg$(OBJ_EXT): utf8.h
mg$(OBJ_EXT): util.h
mg$(OBJ_EXT): warnings.h
mg$(OBJ_EXT): zaphod32_hash.h
mg$(OBJ_EXT): cflags
mro_core$(OBJ_EXT): CROSS_ROOT/include/alloca.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/assert.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/ctype.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/dirent.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/endian.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/errno.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/features.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/float.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/limits.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/locale.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/math.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/netdb.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/signal.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/stddef.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/stdint.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/stdio.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/string.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/strings.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/time.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/unistd.h
mro_core$(OBJ_EXT): CROSS_ROOT/include/wchar.h
mro_core$(OBJ_EXT): EXTERN.h
mro_core$(OBJ_EXT): XSUB.h
mro_core$(OBJ_EXT): av.h
mro_core$(OBJ_EXT): charclass_invlists.h
mro_core$(OBJ_EXT): config.h
mro_core$(OBJ_EXT): cop.h
mro_core$(OBJ_EXT): cv.h
mro_core$(OBJ_EXT): embed.h
mro_core$(OBJ_EXT): embedvar.h
mro_core$(OBJ_EXT): form.h
mro_core$(OBJ_EXT): gv.h
mro_core$(OBJ_EXT): handy.h
mro_core$(OBJ_EXT): hv.h
mro_core$(OBJ_EXT): hv_func.h
mro_core$(OBJ_EXT): hv_macro.h
mro_core$(OBJ_EXT): inline.h
mro_core$(OBJ_EXT): intrpvar.h
mro_core$(OBJ_EXT): iperlsys.h
mro_core$(OBJ_EXT): locale_table.h
mro_core$(OBJ_EXT): mg.h
mro_core$(OBJ_EXT): mg_vtable.h
mro_core$(OBJ_EXT): mro_core.c
mro_core$(OBJ_EXT): mydtrace.h
mro_core$(OBJ_EXT): nostdio.h
mro_core$(OBJ_EXT): op.h
mro_core$(OBJ_EXT): op_reg_common.h
mro_core$(OBJ_EXT): opcode.h
mro_core$(OBJ_EXT): opnames.h
mro_core$(OBJ_EXT): overload.h
mro_core$(OBJ_EXT): pad.h
mro_core$(OBJ_EXT): parser.h
mro_core$(OBJ_EXT): patchlevel.h
mro_core$(OBJ_EXT): perl.h
mro_core$(OBJ_EXT): perl_langinfo.h
mro_core$(OBJ_EXT): perl_siphash.h
mro_core$(OBJ_EXT): perlio.h
mro_core$(OBJ_EXT): perlstatic.h
mro_core$(OBJ_EXT): perlvars.h
mro_core$(OBJ_EXT): perly.h
mro_core$(OBJ_EXT): pp.h
mro_core$(OBJ_EXT): pp_proto.h
mro_core$(OBJ_EXT): proto.h
mro_core$(OBJ_EXT): regcharclass.h
mro_core$(OBJ_EXT): regexp.h
mro_core$(OBJ_EXT): sbox32_hash.h
mro_core$(OBJ_EXT): scope.h
mro_core$(OBJ_EXT): scope_types.h
mro_core$(OBJ_EXT): sv.h
mro_core$(OBJ_EXT): sv_inline.h
mro_core$(OBJ_EXT): thread.h
mro_core$(OBJ_EXT): unicode_constants.h
mro_core$(OBJ_EXT): unixish.h
mro_core$(OBJ_EXT): utf8.h
mro_core$(OBJ_EXT): util.h
mro_core$(OBJ_EXT): warnings.h
mro_core$(OBJ_EXT): zaphod32_hash.h
mro_core$(OBJ_EXT): cflags
numeric$(OBJ_EXT): CROSS_ROOT/include/alloca.h
numeric$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
numeric$(OBJ_EXT): CROSS_ROOT/include/assert.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
numeric$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
numeric$(OBJ_EXT): CROSS_ROOT/include/ctype.h
numeric$(OBJ_EXT): CROSS_ROOT/include/dirent.h
numeric$(OBJ_EXT): CROSS_ROOT/include/endian.h
numeric$(OBJ_EXT): CROSS_ROOT/include/errno.h
numeric$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
numeric$(OBJ_EXT): CROSS_ROOT/include/features.h
numeric$(OBJ_EXT): CROSS_ROOT/include/float.h
numeric$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
numeric$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
numeric$(OBJ_EXT): CROSS_ROOT/include/limits.h
numeric$(OBJ_EXT): CROSS_ROOT/include/locale.h
numeric$(OBJ_EXT): CROSS_ROOT/include/math.h
numeric$(OBJ_EXT): CROSS_ROOT/include/netdb.h
numeric$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
numeric$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
numeric$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
numeric$(OBJ_EXT): CROSS_ROOT/include/signal.h
numeric$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
numeric$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
numeric$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
numeric$(OBJ_EXT): CROSS_ROOT/include/stddef.h
numeric$(OBJ_EXT): CROSS_ROOT/include/stdint.h
numeric$(OBJ_EXT): CROSS_ROOT/include/stdio.h
numeric$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
numeric$(OBJ_EXT): CROSS_ROOT/include/string.h
numeric$(OBJ_EXT): CROSS_ROOT/include/strings.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
numeric$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
numeric$(OBJ_EXT): CROSS_ROOT/include/time.h
numeric$(OBJ_EXT): CROSS_ROOT/include/unistd.h
numeric$(OBJ_EXT): CROSS_ROOT/include/wchar.h
numeric$(OBJ_EXT): EXTERN.h
numeric$(OBJ_EXT): av.h
numeric$(OBJ_EXT): charclass_invlists.h
numeric$(OBJ_EXT): config.h
numeric$(OBJ_EXT): cop.h
numeric$(OBJ_EXT): cv.h
numeric$(OBJ_EXT): embed.h
numeric$(OBJ_EXT): embedvar.h
numeric$(OBJ_EXT): form.h
numeric$(OBJ_EXT): gv.h
numeric$(OBJ_EXT): handy.h
numeric$(OBJ_EXT): hv.h
numeric$(OBJ_EXT): hv_func.h
numeric$(OBJ_EXT): hv_macro.h
numeric$(OBJ_EXT): inline.h
numeric$(OBJ_EXT): intrpvar.h
numeric$(OBJ_EXT): iperlsys.h
numeric$(OBJ_EXT): locale_table.h
numeric$(OBJ_EXT): mg.h
numeric$(OBJ_EXT): mg_vtable.h
numeric$(OBJ_EXT): mydtrace.h
numeric$(OBJ_EXT): nostdio.h
numeric$(OBJ_EXT): numeric.c
numeric$(OBJ_EXT): op.h
numeric$(OBJ_EXT): op_reg_common.h
numeric$(OBJ_EXT): opcode.h
numeric$(OBJ_EXT): opnames.h
numeric$(OBJ_EXT): overload.h
numeric$(OBJ_EXT): pad.h
numeric$(OBJ_EXT): parser.h
numeric$(OBJ_EXT): patchlevel.h
numeric$(OBJ_EXT): perl.h
numeric$(OBJ_EXT): perl_langinfo.h
numeric$(OBJ_EXT): perl_siphash.h
numeric$(OBJ_EXT): perlio.h
numeric$(OBJ_EXT): perlstatic.h
numeric$(OBJ_EXT): perlvars.h
numeric$(OBJ_EXT): perly.h
numeric$(OBJ_EXT): pp.h
numeric$(OBJ_EXT): pp_proto.h
numeric$(OBJ_EXT): proto.h
numeric$(OBJ_EXT): regcharclass.h
numeric$(OBJ_EXT): regexp.h
numeric$(OBJ_EXT): sbox32_hash.h
numeric$(OBJ_EXT): scope.h
numeric$(OBJ_EXT): scope_types.h
numeric$(OBJ_EXT): sv.h
numeric$(OBJ_EXT): sv_inline.h
numeric$(OBJ_EXT): thread.h
numeric$(OBJ_EXT): unicode_constants.h
numeric$(OBJ_EXT): unixish.h
numeric$(OBJ_EXT): utf8.h
numeric$(OBJ_EXT): util.h
numeric$(OBJ_EXT): warnings.h
numeric$(OBJ_EXT): zaphod32_hash.h
numeric$(OBJ_EXT): cflags
op$(OBJ_EXT): CROSS_ROOT/include/alloca.h
op$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
op$(OBJ_EXT): CROSS_ROOT/include/assert.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
op$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
op$(OBJ_EXT): CROSS_ROOT/include/ctype.h
op$(OBJ_EXT): CROSS_ROOT/include/dirent.h
op$(OBJ_EXT): CROSS_ROOT/include/endian.h
op$(OBJ_EXT): CROSS_ROOT/include/errno.h
op$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
op$(OBJ_EXT): CROSS_ROOT/include/features.h
op$(OBJ_EXT): CROSS_ROOT/include/float.h
op$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
op$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
op$(OBJ_EXT): CROSS_ROOT/include/limits.h
op$(OBJ_EXT): CROSS_ROOT/include/locale.h
op$(OBJ_EXT): CROSS_ROOT/include/math.h
op$(OBJ_EXT): CROSS_ROOT/include/netdb.h
op$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
op$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
op$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
op$(OBJ_EXT): CROSS_ROOT/include/signal.h
op$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
op$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
op$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
op$(OBJ_EXT): CROSS_ROOT/include/stddef.h
op$(OBJ_EXT): CROSS_ROOT/include/stdint.h
op$(OBJ_EXT): CROSS_ROOT/include/stdio.h
op$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
op$(OBJ_EXT): CROSS_ROOT/include/string.h
op$(OBJ_EXT): CROSS_ROOT/include/strings.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
op$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
op$(OBJ_EXT): CROSS_ROOT/include/time.h
op$(OBJ_EXT): CROSS_ROOT/include/unistd.h
op$(OBJ_EXT): CROSS_ROOT/include/wchar.h
op$(OBJ_EXT): EXTERN.h
op$(OBJ_EXT): XSUB.h
op$(OBJ_EXT): av.h
op$(OBJ_EXT): charclass_invlists.h
op$(OBJ_EXT): config.h
op$(OBJ_EXT): cop.h
op$(OBJ_EXT): cv.h
op$(OBJ_EXT): embed.h
op$(OBJ_EXT): embedvar.h
op$(OBJ_EXT): feature.h
op$(OBJ_EXT): form.h
op$(OBJ_EXT): gv.h
op$(OBJ_EXT): handy.h
op$(OBJ_EXT): hv.h
op$(OBJ_EXT): hv_func.h
op$(OBJ_EXT): hv_macro.h
op$(OBJ_EXT): inline.h
op$(OBJ_EXT): intrpvar.h
op$(OBJ_EXT): invlist_inline.h
op$(OBJ_EXT): iperlsys.h
op$(OBJ_EXT): keywords.h
op$(OBJ_EXT): locale_table.h
op$(OBJ_EXT): mg.h
op$(OBJ_EXT): mg_vtable.h
op$(OBJ_EXT): mydtrace.h
op$(OBJ_EXT): nostdio.h
op$(OBJ_EXT): op.c
op$(OBJ_EXT): op.h
op$(OBJ_EXT): op_reg_common.h
op$(OBJ_EXT): opcode.h
op$(OBJ_EXT): opnames.h
op$(OBJ_EXT): overload.h
op$(OBJ_EXT): pad.h
op$(OBJ_EXT): parser.h
op$(OBJ_EXT): patchlevel.h
op$(OBJ_EXT): perl.h
op$(OBJ_EXT): perl_langinfo.h
op$(OBJ_EXT): perl_siphash.h
op$(OBJ_EXT): perlio.h
op$(OBJ_EXT): perlstatic.h
op$(OBJ_EXT): perlvars.h
op$(OBJ_EXT): perly.h
op$(OBJ_EXT): pp.h
op$(OBJ_EXT): pp_proto.h
op$(OBJ_EXT): proto.h
op$(OBJ_EXT): regcharclass.h
op$(OBJ_EXT): regcomp.h
op$(OBJ_EXT): regexp.h
op$(OBJ_EXT): regnodes.h
op$(OBJ_EXT): sbox32_hash.h
op$(OBJ_EXT): scope.h
op$(OBJ_EXT): scope_types.h
op$(OBJ_EXT): sv.h
op$(OBJ_EXT): sv_inline.h
op$(OBJ_EXT): thread.h
op$(OBJ_EXT): unicode_constants.h
op$(OBJ_EXT): unixish.h
op$(OBJ_EXT): utf8.h
op$(OBJ_EXT): util.h
op$(OBJ_EXT): warnings.h
op$(OBJ_EXT): zaphod32_hash.h
op$(OBJ_EXT): cflags
pad$(OBJ_EXT): CROSS_ROOT/include/alloca.h
pad$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
pad$(OBJ_EXT): CROSS_ROOT/include/assert.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
pad$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
pad$(OBJ_EXT): CROSS_ROOT/include/ctype.h
pad$(OBJ_EXT): CROSS_ROOT/include/dirent.h
pad$(OBJ_EXT): CROSS_ROOT/include/endian.h
pad$(OBJ_EXT): CROSS_ROOT/include/errno.h
pad$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
pad$(OBJ_EXT): CROSS_ROOT/include/features.h
pad$(OBJ_EXT): CROSS_ROOT/include/float.h
pad$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
pad$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
pad$(OBJ_EXT): CROSS_ROOT/include/limits.h
pad$(OBJ_EXT): CROSS_ROOT/include/locale.h
pad$(OBJ_EXT): CROSS_ROOT/include/math.h
pad$(OBJ_EXT): CROSS_ROOT/include/netdb.h
pad$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
pad$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
pad$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
pad$(OBJ_EXT): CROSS_ROOT/include/signal.h
pad$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
pad$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
pad$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
pad$(OBJ_EXT): CROSS_ROOT/include/stddef.h
pad$(OBJ_EXT): CROSS_ROOT/include/stdint.h
pad$(OBJ_EXT): CROSS_ROOT/include/stdio.h
pad$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
pad$(OBJ_EXT): CROSS_ROOT/include/string.h
pad$(OBJ_EXT): CROSS_ROOT/include/strings.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
pad$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
pad$(OBJ_EXT): CROSS_ROOT/include/time.h
pad$(OBJ_EXT): CROSS_ROOT/include/unistd.h
pad$(OBJ_EXT): CROSS_ROOT/include/wchar.h
pad$(OBJ_EXT): EXTERN.h
pad$(OBJ_EXT): av.h
pad$(OBJ_EXT): charclass_invlists.h
pad$(OBJ_EXT): config.h
pad$(OBJ_EXT): cop.h
pad$(OBJ_EXT): cv.h
pad$(OBJ_EXT): embed.h
pad$(OBJ_EXT): embedvar.h
pad$(OBJ_EXT): form.h
pad$(OBJ_EXT): gv.h
pad$(OBJ_EXT): handy.h
pad$(OBJ_EXT): hv.h
pad$(OBJ_EXT): hv_func.h
pad$(OBJ_EXT): hv_macro.h
pad$(OBJ_EXT): inline.h
pad$(OBJ_EXT): intrpvar.h
pad$(OBJ_EXT): iperlsys.h
pad$(OBJ_EXT): keywords.h
pad$(OBJ_EXT): locale_table.h
pad$(OBJ_EXT): mg.h
pad$(OBJ_EXT): mg_vtable.h
pad$(OBJ_EXT): mydtrace.h
pad$(OBJ_EXT): nostdio.h
pad$(OBJ_EXT): op.h
pad$(OBJ_EXT): op_reg_common.h
pad$(OBJ_EXT): opcode.h
pad$(OBJ_EXT): opnames.h
pad$(OBJ_EXT): overload.h
pad$(OBJ_EXT): pad.c
pad$(OBJ_EXT): pad.h
pad$(OBJ_EXT): parser.h
pad$(OBJ_EXT): patchlevel.h
pad$(OBJ_EXT): perl.h
pad$(OBJ_EXT): perl_langinfo.h
pad$(OBJ_EXT): perl_siphash.h
pad$(OBJ_EXT): perlio.h
pad$(OBJ_EXT): perlstatic.h
pad$(OBJ_EXT): perlvars.h
pad$(OBJ_EXT): perly.h
pad$(OBJ_EXT): pp.h
pad$(OBJ_EXT): pp_proto.h
pad$(OBJ_EXT): proto.h
pad$(OBJ_EXT): regcharclass.h
pad$(OBJ_EXT): regexp.h
pad$(OBJ_EXT): sbox32_hash.h
pad$(OBJ_EXT): scope.h
pad$(OBJ_EXT): scope_types.h
pad$(OBJ_EXT): sv.h
pad$(OBJ_EXT): sv_inline.h
pad$(OBJ_EXT): thread.h
pad$(OBJ_EXT): unicode_constants.h
pad$(OBJ_EXT): unixish.h
pad$(OBJ_EXT): utf8.h
pad$(OBJ_EXT): util.h
pad$(OBJ_EXT): warnings.h
pad$(OBJ_EXT): zaphod32_hash.h
pad$(OBJ_EXT): cflags
peep$(OBJ_EXT): CROSS_ROOT/include/alloca.h
peep$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
peep$(OBJ_EXT): CROSS_ROOT/include/assert.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
peep$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
peep$(OBJ_EXT): CROSS_ROOT/include/ctype.h
peep$(OBJ_EXT): CROSS_ROOT/include/dirent.h
peep$(OBJ_EXT): CROSS_ROOT/include/endian.h
peep$(OBJ_EXT): CROSS_ROOT/include/errno.h
peep$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
peep$(OBJ_EXT): CROSS_ROOT/include/features.h
peep$(OBJ_EXT): CROSS_ROOT/include/float.h
peep$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
peep$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
peep$(OBJ_EXT): CROSS_ROOT/include/limits.h
peep$(OBJ_EXT): CROSS_ROOT/include/locale.h
peep$(OBJ_EXT): CROSS_ROOT/include/math.h
peep$(OBJ_EXT): CROSS_ROOT/include/netdb.h
peep$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
peep$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
peep$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
peep$(OBJ_EXT): CROSS_ROOT/include/signal.h
peep$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
peep$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
peep$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
peep$(OBJ_EXT): CROSS_ROOT/include/stddef.h
peep$(OBJ_EXT): CROSS_ROOT/include/stdint.h
peep$(OBJ_EXT): CROSS_ROOT/include/stdio.h
peep$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
peep$(OBJ_EXT): CROSS_ROOT/include/string.h
peep$(OBJ_EXT): CROSS_ROOT/include/strings.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
peep$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
peep$(OBJ_EXT): CROSS_ROOT/include/time.h
peep$(OBJ_EXT): CROSS_ROOT/include/unistd.h
peep$(OBJ_EXT): CROSS_ROOT/include/wchar.h
peep$(OBJ_EXT): EXTERN.h
peep$(OBJ_EXT): av.h
peep$(OBJ_EXT): charclass_invlists.h
peep$(OBJ_EXT): config.h
peep$(OBJ_EXT): cop.h
peep$(OBJ_EXT): cv.h
peep$(OBJ_EXT): embed.h
peep$(OBJ_EXT): embedvar.h
peep$(OBJ_EXT): form.h
peep$(OBJ_EXT): gv.h
peep$(OBJ_EXT): handy.h
peep$(OBJ_EXT): hv.h
peep$(OBJ_EXT): hv_func.h
peep$(OBJ_EXT): hv_macro.h
peep$(OBJ_EXT): inline.h
peep$(OBJ_EXT): intrpvar.h
peep$(OBJ_EXT): iperlsys.h
peep$(OBJ_EXT): locale_table.h
peep$(OBJ_EXT): mg.h
peep$(OBJ_EXT): mg_vtable.h
peep$(OBJ_EXT): mydtrace.h
peep$(OBJ_EXT): nostdio.h
peep$(OBJ_EXT): op.h
peep$(OBJ_EXT): op_reg_common.h
peep$(OBJ_EXT): opcode.h
peep$(OBJ_EXT): opnames.h
peep$(OBJ_EXT): overload.h
peep$(OBJ_EXT): pad.h
peep$(OBJ_EXT): parser.h
peep$(OBJ_EXT): patchlevel.h
peep$(OBJ_EXT): peep.c
peep$(OBJ_EXT): perl.h
peep$(OBJ_EXT): perl_langinfo.h
peep$(OBJ_EXT): perl_siphash.h
peep$(OBJ_EXT): perlio.h
peep$(OBJ_EXT): perlstatic.h
peep$(OBJ_EXT): perlvars.h
peep$(OBJ_EXT): perly.h
peep$(OBJ_EXT): pp.h
peep$(OBJ_EXT): pp_proto.h
peep$(OBJ_EXT): proto.h
peep$(OBJ_EXT): regcharclass.h
peep$(OBJ_EXT): regexp.h
peep$(OBJ_EXT): sbox32_hash.h
peep$(OBJ_EXT): scope.h
peep$(OBJ_EXT): scope_types.h
peep$(OBJ_EXT): sv.h
peep$(OBJ_EXT): sv_inline.h
peep$(OBJ_EXT): thread.h
peep$(OBJ_EXT): unicode_constants.h
peep$(OBJ_EXT): unixish.h
peep$(OBJ_EXT): utf8.h
peep$(OBJ_EXT): util.h
peep$(OBJ_EXT): warnings.h
peep$(OBJ_EXT): zaphod32_hash.h
peep$(OBJ_EXT): cflags
perl$(OBJ_EXT): CROSS_ROOT/include/alloca.h
perl$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
perl$(OBJ_EXT): CROSS_ROOT/include/assert.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
perl$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
perl$(OBJ_EXT): CROSS_ROOT/include/ctype.h
perl$(OBJ_EXT): CROSS_ROOT/include/dirent.h
perl$(OBJ_EXT): CROSS_ROOT/include/endian.h
perl$(OBJ_EXT): CROSS_ROOT/include/errno.h
perl$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
perl$(OBJ_EXT): CROSS_ROOT/include/features.h
perl$(OBJ_EXT): CROSS_ROOT/include/float.h
perl$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
perl$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
perl$(OBJ_EXT): CROSS_ROOT/include/limits.h
perl$(OBJ_EXT): CROSS_ROOT/include/locale.h
perl$(OBJ_EXT): CROSS_ROOT/include/math.h
perl$(OBJ_EXT): CROSS_ROOT/include/netdb.h
perl$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
perl$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
perl$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
perl$(OBJ_EXT): CROSS_ROOT/include/signal.h
perl$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
perl$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
perl$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
perl$(OBJ_EXT): CROSS_ROOT/include/stddef.h
perl$(OBJ_EXT): CROSS_ROOT/include/stdint.h
perl$(OBJ_EXT): CROSS_ROOT/include/stdio.h
perl$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
perl$(OBJ_EXT): CROSS_ROOT/include/string.h
perl$(OBJ_EXT): CROSS_ROOT/include/strings.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
perl$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
perl$(OBJ_EXT): CROSS_ROOT/include/time.h
perl$(OBJ_EXT): CROSS_ROOT/include/unistd.h
perl$(OBJ_EXT): CROSS_ROOT/include/wchar.h
perl$(OBJ_EXT): EXTERN.h
perl$(OBJ_EXT): av.h
perl$(OBJ_EXT): charclass_invlists.h
perl$(OBJ_EXT): config.h
perl$(OBJ_EXT): cop.h
perl$(OBJ_EXT): cv.h
perl$(OBJ_EXT): embed.h
perl$(OBJ_EXT): embedvar.h
perl$(OBJ_EXT): form.h
perl$(OBJ_EXT): gv.h
perl$(OBJ_EXT): handy.h
perl$(OBJ_EXT): hv.h
perl$(OBJ_EXT): hv_func.h
perl$(OBJ_EXT): hv_macro.h
perl$(OBJ_EXT): inline.h
perl$(OBJ_EXT): intrpvar.h
perl$(OBJ_EXT): iperlsys.h
perl$(OBJ_EXT): locale_table.h
perl$(OBJ_EXT): mg.h
perl$(OBJ_EXT): mg_vtable.h
perl$(OBJ_EXT): mydtrace.h
perl$(OBJ_EXT): nostdio.h
perl$(OBJ_EXT): op.h
perl$(OBJ_EXT): op_reg_common.h
perl$(OBJ_EXT): opcode.h
perl$(OBJ_EXT): opnames.h
perl$(OBJ_EXT): overload.h
perl$(OBJ_EXT): pad.h
perl$(OBJ_EXT): parser.h
perl$(OBJ_EXT): patchlevel.h
perl$(OBJ_EXT): perl.c
perl$(OBJ_EXT): perl.h
perl$(OBJ_EXT): perl_langinfo.h
perl$(OBJ_EXT): perl_siphash.h
perl$(OBJ_EXT): perlio.h
perl$(OBJ_EXT): perlstatic.h
perl$(OBJ_EXT): perlvars.h
perl$(OBJ_EXT): perly.h
perl$(OBJ_EXT): pp.h
perl$(OBJ_EXT): pp_proto.h
perl$(OBJ_EXT): proto.h
perl$(OBJ_EXT): regcharclass.h
perl$(OBJ_EXT): regexp.h
perl$(OBJ_EXT): sbox32_hash.h
perl$(OBJ_EXT): scope.h
perl$(OBJ_EXT): scope_types.h
perl$(OBJ_EXT): sv.h
perl$(OBJ_EXT): sv_inline.h
perl$(OBJ_EXT): thread.h
perl$(OBJ_EXT): unicode_constants.h
perl$(OBJ_EXT): unixish.h
perl$(OBJ_EXT): utf8.h
perl$(OBJ_EXT): util.h
perl$(OBJ_EXT): warnings.h
perl$(OBJ_EXT): zaphod32_hash.h
perl$(OBJ_EXT): cflags
perlio$(OBJ_EXT): CROSS_ROOT/include/alloca.h
perlio$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
perlio$(OBJ_EXT): CROSS_ROOT/include/assert.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
perlio$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
perlio$(OBJ_EXT): CROSS_ROOT/include/ctype.h
perlio$(OBJ_EXT): CROSS_ROOT/include/dirent.h
perlio$(OBJ_EXT): CROSS_ROOT/include/endian.h
perlio$(OBJ_EXT): CROSS_ROOT/include/errno.h
perlio$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
perlio$(OBJ_EXT): CROSS_ROOT/include/features.h
perlio$(OBJ_EXT): CROSS_ROOT/include/float.h
perlio$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
perlio$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
perlio$(OBJ_EXT): CROSS_ROOT/include/limits.h
perlio$(OBJ_EXT): CROSS_ROOT/include/locale.h
perlio$(OBJ_EXT): CROSS_ROOT/include/math.h
perlio$(OBJ_EXT): CROSS_ROOT/include/netdb.h
perlio$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
perlio$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
perlio$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
perlio$(OBJ_EXT): CROSS_ROOT/include/signal.h
perlio$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
perlio$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
perlio$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
perlio$(OBJ_EXT): CROSS_ROOT/include/stddef.h
perlio$(OBJ_EXT): CROSS_ROOT/include/stdint.h
perlio$(OBJ_EXT): CROSS_ROOT/include/stdio.h
perlio$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
perlio$(OBJ_EXT): CROSS_ROOT/include/string.h
perlio$(OBJ_EXT): CROSS_ROOT/include/strings.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
perlio$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
perlio$(OBJ_EXT): CROSS_ROOT/include/time.h
perlio$(OBJ_EXT): CROSS_ROOT/include/unistd.h
perlio$(OBJ_EXT): CROSS_ROOT/include/wchar.h
perlio$(OBJ_EXT): EXTERN.h
perlio$(OBJ_EXT): XSUB.h
perlio$(OBJ_EXT): av.h
perlio$(OBJ_EXT): charclass_invlists.h
perlio$(OBJ_EXT): config.h
perlio$(OBJ_EXT): cop.h
perlio$(OBJ_EXT): cv.h
perlio$(OBJ_EXT): embed.h
perlio$(OBJ_EXT): embedvar.h
perlio$(OBJ_EXT): form.h
perlio$(OBJ_EXT): gv.h
perlio$(OBJ_EXT): handy.h
perlio$(OBJ_EXT): hv.h
perlio$(OBJ_EXT): hv_func.h
perlio$(OBJ_EXT): hv_macro.h
perlio$(OBJ_EXT): inline.h
perlio$(OBJ_EXT): intrpvar.h
perlio$(OBJ_EXT): iperlsys.h
perlio$(OBJ_EXT): locale_table.h
perlio$(OBJ_EXT): mg.h
perlio$(OBJ_EXT): mg_vtable.h
perlio$(OBJ_EXT): mydtrace.h
perlio$(OBJ_EXT): op.h
perlio$(OBJ_EXT): op_reg_common.h
perlio$(OBJ_EXT): opcode.h
perlio$(OBJ_EXT): opnames.h
perlio$(OBJ_EXT): overload.h
perlio$(OBJ_EXT): pad.h
perlio$(OBJ_EXT): parser.h
perlio$(OBJ_EXT): patchlevel.h
perlio$(OBJ_EXT): perl.h
perlio$(OBJ_EXT): perl_langinfo.h
perlio$(OBJ_EXT): perl_siphash.h
perlio$(OBJ_EXT): perlio.c
perlio$(OBJ_EXT): perlio.h
perlio$(OBJ_EXT): perliol.h
perlio$(OBJ_EXT): perlstatic.h
perlio$(OBJ_EXT): perlvars.h
perlio$(OBJ_EXT): perly.h
perlio$(OBJ_EXT): pp.h
perlio$(OBJ_EXT): pp_proto.h
perlio$(OBJ_EXT): proto.h
perlio$(OBJ_EXT): regcharclass.h
perlio$(OBJ_EXT): regexp.h
perlio$(OBJ_EXT): sbox32_hash.h
perlio$(OBJ_EXT): scope.h
perlio$(OBJ_EXT): scope_types.h
perlio$(OBJ_EXT): sv.h
perlio$(OBJ_EXT): sv_inline.h
perlio$(OBJ_EXT): thread.h
perlio$(OBJ_EXT): unicode_constants.h
perlio$(OBJ_EXT): unixish.h
perlio$(OBJ_EXT): utf8.h
perlio$(OBJ_EXT): util.h
perlio$(OBJ_EXT): warnings.h
perlio$(OBJ_EXT): zaphod32_hash.h
perlio$(OBJ_EXT): cflags
perly$(OBJ_EXT): CROSS_ROOT/include/alloca.h
perly$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
perly$(OBJ_EXT): CROSS_ROOT/include/assert.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
perly$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
perly$(OBJ_EXT): CROSS_ROOT/include/ctype.h
perly$(OBJ_EXT): CROSS_ROOT/include/dirent.h
perly$(OBJ_EXT): CROSS_ROOT/include/endian.h
perly$(OBJ_EXT): CROSS_ROOT/include/errno.h
perly$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
perly$(OBJ_EXT): CROSS_ROOT/include/features.h
perly$(OBJ_EXT): CROSS_ROOT/include/float.h
perly$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
perly$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
perly$(OBJ_EXT): CROSS_ROOT/include/limits.h
perly$(OBJ_EXT): CROSS_ROOT/include/locale.h
perly$(OBJ_EXT): CROSS_ROOT/include/math.h
perly$(OBJ_EXT): CROSS_ROOT/include/netdb.h
perly$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
perly$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
perly$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
perly$(OBJ_EXT): CROSS_ROOT/include/signal.h
perly$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
perly$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
perly$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
perly$(OBJ_EXT): CROSS_ROOT/include/stddef.h
perly$(OBJ_EXT): CROSS_ROOT/include/stdint.h
perly$(OBJ_EXT): CROSS_ROOT/include/stdio.h
perly$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
perly$(OBJ_EXT): CROSS_ROOT/include/string.h
perly$(OBJ_EXT): CROSS_ROOT/include/strings.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
perly$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
perly$(OBJ_EXT): CROSS_ROOT/include/time.h
perly$(OBJ_EXT): CROSS_ROOT/include/unistd.h
perly$(OBJ_EXT): CROSS_ROOT/include/wchar.h
perly$(OBJ_EXT): EXTERN.h
perly$(OBJ_EXT): av.h
perly$(OBJ_EXT): charclass_invlists.h
perly$(OBJ_EXT): config.h
perly$(OBJ_EXT): cop.h
perly$(OBJ_EXT): cv.h
perly$(OBJ_EXT): embed.h
perly$(OBJ_EXT): embedvar.h
perly$(OBJ_EXT): feature.h
perly$(OBJ_EXT): form.h
perly$(OBJ_EXT): gv.h
perly$(OBJ_EXT): handy.h
perly$(OBJ_EXT): hv.h
perly$(OBJ_EXT): hv_func.h
perly$(OBJ_EXT): hv_macro.h
perly$(OBJ_EXT): inline.h
perly$(OBJ_EXT): intrpvar.h
perly$(OBJ_EXT): iperlsys.h
perly$(OBJ_EXT): keywords.h
perly$(OBJ_EXT): locale_table.h
perly$(OBJ_EXT): mg.h
perly$(OBJ_EXT): mg_vtable.h
perly$(OBJ_EXT): mydtrace.h
perly$(OBJ_EXT): nostdio.h
perly$(OBJ_EXT): op.h
perly$(OBJ_EXT): op_reg_common.h
perly$(OBJ_EXT): opcode.h
perly$(OBJ_EXT): opnames.h
perly$(OBJ_EXT): overload.h
perly$(OBJ_EXT): pad.h
perly$(OBJ_EXT): parser.h
perly$(OBJ_EXT): patchlevel.h
perly$(OBJ_EXT): perl.h
perly$(OBJ_EXT): perl_langinfo.h
perly$(OBJ_EXT): perl_siphash.h
perly$(OBJ_EXT): perlio.h
perly$(OBJ_EXT): perlstatic.h
perly$(OBJ_EXT): perlvars.h
perly$(OBJ_EXT): perly.act
perly$(OBJ_EXT): perly.c
perly$(OBJ_EXT): perly.h
perly$(OBJ_EXT): perly.tab
perly$(OBJ_EXT): perly.y
perly$(OBJ_EXT): pp.h
perly$(OBJ_EXT): pp_proto.h
perly$(OBJ_EXT): proto.h
perly$(OBJ_EXT): regcharclass.h
perly$(OBJ_EXT): regexp.h
perly$(OBJ_EXT): sbox32_hash.h
perly$(OBJ_EXT): scope.h
perly$(OBJ_EXT): scope_types.h
perly$(OBJ_EXT): sv.h
perly$(OBJ_EXT): sv_inline.h
perly$(OBJ_EXT): thread.h
perly$(OBJ_EXT): unicode_constants.h
perly$(OBJ_EXT): unixish.h
perly$(OBJ_EXT): utf8.h
perly$(OBJ_EXT): util.h
perly$(OBJ_EXT): warnings.h
perly$(OBJ_EXT): zaphod32_hash.h
perly$(OBJ_EXT): cflags
pp$(OBJ_EXT): CROSS_ROOT/include/alloca.h
pp$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
pp$(OBJ_EXT): CROSS_ROOT/include/assert.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
pp$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
pp$(OBJ_EXT): CROSS_ROOT/include/ctype.h
pp$(OBJ_EXT): CROSS_ROOT/include/dirent.h
pp$(OBJ_EXT): CROSS_ROOT/include/endian.h
pp$(OBJ_EXT): CROSS_ROOT/include/errno.h
pp$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
pp$(OBJ_EXT): CROSS_ROOT/include/features.h
pp$(OBJ_EXT): CROSS_ROOT/include/float.h
pp$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
pp$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
pp$(OBJ_EXT): CROSS_ROOT/include/limits.h
pp$(OBJ_EXT): CROSS_ROOT/include/locale.h
pp$(OBJ_EXT): CROSS_ROOT/include/math.h
pp$(OBJ_EXT): CROSS_ROOT/include/netdb.h
pp$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
pp$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
pp$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
pp$(OBJ_EXT): CROSS_ROOT/include/signal.h
pp$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
pp$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
pp$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
pp$(OBJ_EXT): CROSS_ROOT/include/stddef.h
pp$(OBJ_EXT): CROSS_ROOT/include/stdint.h
pp$(OBJ_EXT): CROSS_ROOT/include/stdio.h
pp$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
pp$(OBJ_EXT): CROSS_ROOT/include/string.h
pp$(OBJ_EXT): CROSS_ROOT/include/strings.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
pp$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
pp$(OBJ_EXT): CROSS_ROOT/include/time.h
pp$(OBJ_EXT): CROSS_ROOT/include/unistd.h
pp$(OBJ_EXT): CROSS_ROOT/include/wchar.h
pp$(OBJ_EXT): EXTERN.h
pp$(OBJ_EXT): av.h
pp$(OBJ_EXT): charclass_invlists.h
pp$(OBJ_EXT): config.h
pp$(OBJ_EXT): cop.h
pp$(OBJ_EXT): cv.h
pp$(OBJ_EXT): embed.h
pp$(OBJ_EXT): embedvar.h
pp$(OBJ_EXT): form.h
pp$(OBJ_EXT): gv.h
pp$(OBJ_EXT): handy.h
pp$(OBJ_EXT): hv.h
pp$(OBJ_EXT): hv_func.h
pp$(OBJ_EXT): hv_macro.h
pp$(OBJ_EXT): inline.h
pp$(OBJ_EXT): intrpvar.h
pp$(OBJ_EXT): invlist_inline.h
pp$(OBJ_EXT): iperlsys.h
pp$(OBJ_EXT): keywords.h
pp$(OBJ_EXT): locale_table.h
pp$(OBJ_EXT): mg.h
pp$(OBJ_EXT): mg_vtable.h
pp$(OBJ_EXT): mydtrace.h
pp$(OBJ_EXT): nostdio.h
pp$(OBJ_EXT): op.h
pp$(OBJ_EXT): op_reg_common.h
pp$(OBJ_EXT): opcode.h
pp$(OBJ_EXT): opnames.h
pp$(OBJ_EXT): overload.h
pp$(OBJ_EXT): pad.h
pp$(OBJ_EXT): parser.h
pp$(OBJ_EXT): patchlevel.h
pp$(OBJ_EXT): perl.h
pp$(OBJ_EXT): perl_langinfo.h
pp$(OBJ_EXT): perl_siphash.h
pp$(OBJ_EXT): perlio.h
pp$(OBJ_EXT): perlstatic.h
pp$(OBJ_EXT): perlvars.h
pp$(OBJ_EXT): perly.h
pp$(OBJ_EXT): pp.c
pp$(OBJ_EXT): pp.h
pp$(OBJ_EXT): pp_proto.h
pp$(OBJ_EXT): proto.h
pp$(OBJ_EXT): reentr.h
pp$(OBJ_EXT): regcharclass.h
pp$(OBJ_EXT): regexp.h
pp$(OBJ_EXT): sbox32_hash.h
pp$(OBJ_EXT): scope.h
pp$(OBJ_EXT): scope_types.h
pp$(OBJ_EXT): sv.h
pp$(OBJ_EXT): sv_inline.h
pp$(OBJ_EXT): thread.h
pp$(OBJ_EXT): unicode_constants.h
pp$(OBJ_EXT): unixish.h
pp$(OBJ_EXT): utf8.h
pp$(OBJ_EXT): util.h
pp$(OBJ_EXT): warnings.h
pp$(OBJ_EXT): zaphod32_hash.h
pp$(OBJ_EXT): cflags
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/alloca.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/assert.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/ctype.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/dirent.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/endian.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/errno.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/features.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/float.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/limits.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/locale.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/math.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/netdb.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/signal.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/stddef.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/stdint.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/stdio.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/string.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/strings.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/time.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/unistd.h
pp_ctl$(OBJ_EXT): CROSS_ROOT/include/wchar.h
pp_ctl$(OBJ_EXT): EXTERN.h
pp_ctl$(OBJ_EXT): av.h
pp_ctl$(OBJ_EXT): charclass_invlists.h
pp_ctl$(OBJ_EXT): config.h
pp_ctl$(OBJ_EXT): cop.h
pp_ctl$(OBJ_EXT): cv.h
pp_ctl$(OBJ_EXT): embed.h
pp_ctl$(OBJ_EXT): embedvar.h
pp_ctl$(OBJ_EXT): feature.h
pp_ctl$(OBJ_EXT): form.h
pp_ctl$(OBJ_EXT): gv.h
pp_ctl$(OBJ_EXT): handy.h
pp_ctl$(OBJ_EXT): hv.h
pp_ctl$(OBJ_EXT): hv_func.h
pp_ctl$(OBJ_EXT): hv_macro.h
pp_ctl$(OBJ_EXT): inline.h
pp_ctl$(OBJ_EXT): intrpvar.h
pp_ctl$(OBJ_EXT): iperlsys.h
pp_ctl$(OBJ_EXT): locale_table.h
pp_ctl$(OBJ_EXT): mg.h
pp_ctl$(OBJ_EXT): mg_vtable.h
pp_ctl$(OBJ_EXT): mydtrace.h
pp_ctl$(OBJ_EXT): nostdio.h
pp_ctl$(OBJ_EXT): op.h
pp_ctl$(OBJ_EXT): op_reg_common.h
pp_ctl$(OBJ_EXT): opcode.h
pp_ctl$(OBJ_EXT): opnames.h
pp_ctl$(OBJ_EXT): overload.h
pp_ctl$(OBJ_EXT): pad.h
pp_ctl$(OBJ_EXT): parser.h
pp_ctl$(OBJ_EXT): patchlevel.h
pp_ctl$(OBJ_EXT): perl.h
pp_ctl$(OBJ_EXT): perl_langinfo.h
pp_ctl$(OBJ_EXT): perl_siphash.h
pp_ctl$(OBJ_EXT): perlio.h
pp_ctl$(OBJ_EXT): perlstatic.h
pp_ctl$(OBJ_EXT): perlvars.h
pp_ctl$(OBJ_EXT): perly.h
pp_ctl$(OBJ_EXT): pp.h
pp_ctl$(OBJ_EXT): pp_ctl.c
pp_ctl$(OBJ_EXT): pp_proto.h
pp_ctl$(OBJ_EXT): proto.h
pp_ctl$(OBJ_EXT): regcharclass.h
pp_ctl$(OBJ_EXT): regexp.h
pp_ctl$(OBJ_EXT): sbox32_hash.h
pp_ctl$(OBJ_EXT): scope.h
pp_ctl$(OBJ_EXT): scope_types.h
pp_ctl$(OBJ_EXT): sv.h
pp_ctl$(OBJ_EXT): sv_inline.h
pp_ctl$(OBJ_EXT): thread.h
pp_ctl$(OBJ_EXT): unicode_constants.h
pp_ctl$(OBJ_EXT): unixish.h
pp_ctl$(OBJ_EXT): utf8.h
pp_ctl$(OBJ_EXT): util.h
pp_ctl$(OBJ_EXT): warnings.h
pp_ctl$(OBJ_EXT): zaphod32_hash.h
pp_ctl$(OBJ_EXT): cflags
pp_hot$(OBJ_EXT): CROSS_ROOT/include/alloca.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/assert.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/ctype.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/dirent.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/endian.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/errno.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/features.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/float.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/limits.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/locale.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/math.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/netdb.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/signal.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/stddef.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/stdint.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/stdio.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/string.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/strings.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/time.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/unistd.h
pp_hot$(OBJ_EXT): CROSS_ROOT/include/wchar.h
pp_hot$(OBJ_EXT): EXTERN.h
pp_hot$(OBJ_EXT): av.h
pp_hot$(OBJ_EXT): charclass_invlists.h
pp_hot$(OBJ_EXT): config.h
pp_hot$(OBJ_EXT): cop.h
pp_hot$(OBJ_EXT): cv.h
pp_hot$(OBJ_EXT): embed.h
pp_hot$(OBJ_EXT): embedvar.h
pp_hot$(OBJ_EXT): feature.h
pp_hot$(OBJ_EXT): form.h
pp_hot$(OBJ_EXT): gv.h
pp_hot$(OBJ_EXT): handy.h
pp_hot$(OBJ_EXT): hv.h
pp_hot$(OBJ_EXT): hv_func.h
pp_hot$(OBJ_EXT): hv_macro.h
pp_hot$(OBJ_EXT): inline.h
pp_hot$(OBJ_EXT): intrpvar.h
pp_hot$(OBJ_EXT): iperlsys.h
pp_hot$(OBJ_EXT): locale_table.h
pp_hot$(OBJ_EXT): mg.h
pp_hot$(OBJ_EXT): mg_vtable.h
pp_hot$(OBJ_EXT): mydtrace.h
pp_hot$(OBJ_EXT): nostdio.h
pp_hot$(OBJ_EXT): op.h
pp_hot$(OBJ_EXT): op_reg_common.h
pp_hot$(OBJ_EXT): opcode.h
pp_hot$(OBJ_EXT): opnames.h
pp_hot$(OBJ_EXT): overload.h
pp_hot$(OBJ_EXT): pad.h
pp_hot$(OBJ_EXT): parser.h
pp_hot$(OBJ_EXT): patchlevel.h
pp_hot$(OBJ_EXT): perl.h
pp_hot$(OBJ_EXT): perl_langinfo.h
pp_hot$(OBJ_EXT): perl_siphash.h
pp_hot$(OBJ_EXT): perlio.h
pp_hot$(OBJ_EXT): perlstatic.h
pp_hot$(OBJ_EXT): perlvars.h
pp_hot$(OBJ_EXT): perly.h
pp_hot$(OBJ_EXT): pp.h
pp_hot$(OBJ_EXT): pp_hot.c
pp_hot$(OBJ_EXT): pp_proto.h
pp_hot$(OBJ_EXT): proto.h
pp_hot$(OBJ_EXT): regcharclass.h
pp_hot$(OBJ_EXT): regcomp.h
pp_hot$(OBJ_EXT): regexp.h
pp_hot$(OBJ_EXT): regnodes.h
pp_hot$(OBJ_EXT): sbox32_hash.h
pp_hot$(OBJ_EXT): scope.h
pp_hot$(OBJ_EXT): scope_types.h
pp_hot$(OBJ_EXT): sv.h
pp_hot$(OBJ_EXT): sv_inline.h
pp_hot$(OBJ_EXT): thread.h
pp_hot$(OBJ_EXT): unicode_constants.h
pp_hot$(OBJ_EXT): unixish.h
pp_hot$(OBJ_EXT): utf8.h
pp_hot$(OBJ_EXT): util.h
pp_hot$(OBJ_EXT): warnings.h
pp_hot$(OBJ_EXT): zaphod32_hash.h
pp_hot$(OBJ_EXT): cflags
pp_pack$(OBJ_EXT): CROSS_ROOT/include/alloca.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/assert.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/ctype.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/dirent.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/endian.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/errno.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/features.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/float.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/limits.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/locale.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/math.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/netdb.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/signal.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/stddef.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/stdint.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/stdio.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/string.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/strings.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/time.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/unistd.h
pp_pack$(OBJ_EXT): CROSS_ROOT/include/wchar.h
pp_pack$(OBJ_EXT): EXTERN.h
pp_pack$(OBJ_EXT): av.h
pp_pack$(OBJ_EXT): charclass_invlists.h
pp_pack$(OBJ_EXT): config.h
pp_pack$(OBJ_EXT): cop.h
pp_pack$(OBJ_EXT): cv.h
pp_pack$(OBJ_EXT): embed.h
pp_pack$(OBJ_EXT): embedvar.h
pp_pack$(OBJ_EXT): form.h
pp_pack$(OBJ_EXT): gv.h
pp_pack$(OBJ_EXT): handy.h
pp_pack$(OBJ_EXT): hv.h
pp_pack$(OBJ_EXT): hv_func.h
pp_pack$(OBJ_EXT): hv_macro.h
pp_pack$(OBJ_EXT): inline.h
pp_pack$(OBJ_EXT): intrpvar.h
pp_pack$(OBJ_EXT): iperlsys.h
pp_pack$(OBJ_EXT): locale_table.h
pp_pack$(OBJ_EXT): mg.h
pp_pack$(OBJ_EXT): mg_vtable.h
pp_pack$(OBJ_EXT): mydtrace.h
pp_pack$(OBJ_EXT): nostdio.h
pp_pack$(OBJ_EXT): op.h
pp_pack$(OBJ_EXT): op_reg_common.h
pp_pack$(OBJ_EXT): opcode.h
pp_pack$(OBJ_EXT): opnames.h
pp_pack$(OBJ_EXT): overload.h
pp_pack$(OBJ_EXT): packsizetables.inc
pp_pack$(OBJ_EXT): pad.h
pp_pack$(OBJ_EXT): parser.h
pp_pack$(OBJ_EXT): patchlevel.h
pp_pack$(OBJ_EXT): perl.h
pp_pack$(OBJ_EXT): perl_langinfo.h
pp_pack$(OBJ_EXT): perl_siphash.h
pp_pack$(OBJ_EXT): perlio.h
pp_pack$(OBJ_EXT): perlstatic.h
pp_pack$(OBJ_EXT): perlvars.h
pp_pack$(OBJ_EXT): perly.h
pp_pack$(OBJ_EXT): pp.h
pp_pack$(OBJ_EXT): pp_pack.c
pp_pack$(OBJ_EXT): pp_proto.h
pp_pack$(OBJ_EXT): proto.h
pp_pack$(OBJ_EXT): regcharclass.h
pp_pack$(OBJ_EXT): regexp.h
pp_pack$(OBJ_EXT): sbox32_hash.h
pp_pack$(OBJ_EXT): scope.h
pp_pack$(OBJ_EXT): scope_types.h
pp_pack$(OBJ_EXT): sv.h
pp_pack$(OBJ_EXT): sv_inline.h
pp_pack$(OBJ_EXT): thread.h
pp_pack$(OBJ_EXT): unicode_constants.h
pp_pack$(OBJ_EXT): unixish.h
pp_pack$(OBJ_EXT): utf8.h
pp_pack$(OBJ_EXT): util.h
pp_pack$(OBJ_EXT): warnings.h
pp_pack$(OBJ_EXT): zaphod32_hash.h
pp_pack$(OBJ_EXT): cflags
pp_sort$(OBJ_EXT): CROSS_ROOT/include/alloca.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/assert.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/ctype.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/dirent.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/endian.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/errno.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/features.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/float.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/limits.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/locale.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/math.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/netdb.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/signal.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/stddef.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/stdint.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/stdio.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/string.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/strings.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/time.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/unistd.h
pp_sort$(OBJ_EXT): CROSS_ROOT/include/wchar.h
pp_sort$(OBJ_EXT): EXTERN.h
pp_sort$(OBJ_EXT): av.h
pp_sort$(OBJ_EXT): charclass_invlists.h
pp_sort$(OBJ_EXT): config.h
pp_sort$(OBJ_EXT): cop.h
pp_sort$(OBJ_EXT): cv.h
pp_sort$(OBJ_EXT): embed.h
pp_sort$(OBJ_EXT): embedvar.h
pp_sort$(OBJ_EXT): form.h
pp_sort$(OBJ_EXT): gv.h
pp_sort$(OBJ_EXT): handy.h
pp_sort$(OBJ_EXT): hv.h
pp_sort$(OBJ_EXT): hv_func.h
pp_sort$(OBJ_EXT): hv_macro.h
pp_sort$(OBJ_EXT): inline.h
pp_sort$(OBJ_EXT): intrpvar.h
pp_sort$(OBJ_EXT): iperlsys.h
pp_sort$(OBJ_EXT): locale_table.h
pp_sort$(OBJ_EXT): mg.h
pp_sort$(OBJ_EXT): mg_vtable.h
pp_sort$(OBJ_EXT): mydtrace.h
pp_sort$(OBJ_EXT): nostdio.h
pp_sort$(OBJ_EXT): op.h
pp_sort$(OBJ_EXT): op_reg_common.h
pp_sort$(OBJ_EXT): opcode.h
pp_sort$(OBJ_EXT): opnames.h
pp_sort$(OBJ_EXT): overload.h
pp_sort$(OBJ_EXT): pad.h
pp_sort$(OBJ_EXT): parser.h
pp_sort$(OBJ_EXT): patchlevel.h
pp_sort$(OBJ_EXT): perl.h
pp_sort$(OBJ_EXT): perl_langinfo.h
pp_sort$(OBJ_EXT): perl_siphash.h
pp_sort$(OBJ_EXT): perlio.h
pp_sort$(OBJ_EXT): perlstatic.h
pp_sort$(OBJ_EXT): perlvars.h
pp_sort$(OBJ_EXT): perly.h
pp_sort$(OBJ_EXT): pp.h
pp_sort$(OBJ_EXT): pp_proto.h
pp_sort$(OBJ_EXT): pp_sort.c
pp_sort$(OBJ_EXT): proto.h
pp_sort$(OBJ_EXT): regcharclass.h
pp_sort$(OBJ_EXT): regexp.h
pp_sort$(OBJ_EXT): sbox32_hash.h
pp_sort$(OBJ_EXT): scope.h
pp_sort$(OBJ_EXT): scope_types.h
pp_sort$(OBJ_EXT): sv.h
pp_sort$(OBJ_EXT): sv_inline.h
pp_sort$(OBJ_EXT): thread.h
pp_sort$(OBJ_EXT): unicode_constants.h
pp_sort$(OBJ_EXT): unixish.h
pp_sort$(OBJ_EXT): utf8.h
pp_sort$(OBJ_EXT): util.h
pp_sort$(OBJ_EXT): warnings.h
pp_sort$(OBJ_EXT): zaphod32_hash.h
pp_sort$(OBJ_EXT): cflags
pp_sys$(OBJ_EXT): CROSS_ROOT/include/alloca.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/assert.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/bits/syscall.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/ctype.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/dirent.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/endian.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/errno.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/features.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/float.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/grp.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/limits.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/locale.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/math.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/netdb.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/pwd.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/shadow.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/signal.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/stddef.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/stdint.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/stdio.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/string.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/strings.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/syscall.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/time.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/unistd.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/utime.h
pp_sys$(OBJ_EXT): CROSS_ROOT/include/wchar.h
pp_sys$(OBJ_EXT): EXTERN.h
pp_sys$(OBJ_EXT): av.h
pp_sys$(OBJ_EXT): charclass_invlists.h
pp_sys$(OBJ_EXT): config.h
pp_sys$(OBJ_EXT): cop.h
pp_sys$(OBJ_EXT): cv.h
pp_sys$(OBJ_EXT): embed.h
pp_sys$(OBJ_EXT): embedvar.h
pp_sys$(OBJ_EXT): form.h
pp_sys$(OBJ_EXT): gv.h
pp_sys$(OBJ_EXT): handy.h
pp_sys$(OBJ_EXT): hv.h
pp_sys$(OBJ_EXT): hv_func.h
pp_sys$(OBJ_EXT): hv_macro.h
pp_sys$(OBJ_EXT): inline.h
pp_sys$(OBJ_EXT): intrpvar.h
pp_sys$(OBJ_EXT): iperlsys.h
pp_sys$(OBJ_EXT): locale_table.h
pp_sys$(OBJ_EXT): mg.h
pp_sys$(OBJ_EXT): mg_vtable.h
pp_sys$(OBJ_EXT): mydtrace.h
pp_sys$(OBJ_EXT): nostdio.h
pp_sys$(OBJ_EXT): op.h
pp_sys$(OBJ_EXT): op_reg_common.h
pp_sys$(OBJ_EXT): opcode.h
pp_sys$(OBJ_EXT): opnames.h
pp_sys$(OBJ_EXT): overload.h
pp_sys$(OBJ_EXT): pad.h
pp_sys$(OBJ_EXT): parser.h
pp_sys$(OBJ_EXT): patchlevel.h
pp_sys$(OBJ_EXT): perl.h
pp_sys$(OBJ_EXT): perl_langinfo.h
pp_sys$(OBJ_EXT): perl_siphash.h
pp_sys$(OBJ_EXT): perlio.h
pp_sys$(OBJ_EXT): perlstatic.h
pp_sys$(OBJ_EXT): perlvars.h
pp_sys$(OBJ_EXT): perly.h
pp_sys$(OBJ_EXT): pp.h
pp_sys$(OBJ_EXT): pp_proto.h
pp_sys$(OBJ_EXT): pp_sys.c
pp_sys$(OBJ_EXT): proto.h
pp_sys$(OBJ_EXT): reentr.h
pp_sys$(OBJ_EXT): regcharclass.h
pp_sys$(OBJ_EXT): regexp.h
pp_sys$(OBJ_EXT): sbox32_hash.h
pp_sys$(OBJ_EXT): scope.h
pp_sys$(OBJ_EXT): scope_types.h
pp_sys$(OBJ_EXT): sv.h
pp_sys$(OBJ_EXT): sv_inline.h
pp_sys$(OBJ_EXT): thread.h
pp_sys$(OBJ_EXT): time64.h
pp_sys$(OBJ_EXT): time64_config.h
pp_sys$(OBJ_EXT): unicode_constants.h
pp_sys$(OBJ_EXT): unixish.h
pp_sys$(OBJ_EXT): utf8.h
pp_sys$(OBJ_EXT): util.h
pp_sys$(OBJ_EXT): warnings.h
pp_sys$(OBJ_EXT): zaphod32_hash.h
pp_sys$(OBJ_EXT): cflags
reentr$(OBJ_EXT): CROSS_ROOT/include/alloca.h
reentr$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
reentr$(OBJ_EXT): CROSS_ROOT/include/assert.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
reentr$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
reentr$(OBJ_EXT): CROSS_ROOT/include/ctype.h
reentr$(OBJ_EXT): CROSS_ROOT/include/dirent.h
reentr$(OBJ_EXT): CROSS_ROOT/include/endian.h
reentr$(OBJ_EXT): CROSS_ROOT/include/errno.h
reentr$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
reentr$(OBJ_EXT): CROSS_ROOT/include/features.h
reentr$(OBJ_EXT): CROSS_ROOT/include/float.h
reentr$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
reentr$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
reentr$(OBJ_EXT): CROSS_ROOT/include/limits.h
reentr$(OBJ_EXT): CROSS_ROOT/include/locale.h
reentr$(OBJ_EXT): CROSS_ROOT/include/math.h
reentr$(OBJ_EXT): CROSS_ROOT/include/netdb.h
reentr$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
reentr$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
reentr$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
reentr$(OBJ_EXT): CROSS_ROOT/include/signal.h
reentr$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
reentr$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
reentr$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
reentr$(OBJ_EXT): CROSS_ROOT/include/stddef.h
reentr$(OBJ_EXT): CROSS_ROOT/include/stdint.h
reentr$(OBJ_EXT): CROSS_ROOT/include/stdio.h
reentr$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
reentr$(OBJ_EXT): CROSS_ROOT/include/string.h
reentr$(OBJ_EXT): CROSS_ROOT/include/strings.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
reentr$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
reentr$(OBJ_EXT): CROSS_ROOT/include/time.h
reentr$(OBJ_EXT): CROSS_ROOT/include/unistd.h
reentr$(OBJ_EXT): CROSS_ROOT/include/wchar.h
reentr$(OBJ_EXT): EXTERN.h
reentr$(OBJ_EXT): av.h
reentr$(OBJ_EXT): charclass_invlists.h
reentr$(OBJ_EXT): config.h
reentr$(OBJ_EXT): cop.h
reentr$(OBJ_EXT): cv.h
reentr$(OBJ_EXT): embed.h
reentr$(OBJ_EXT): embedvar.h
reentr$(OBJ_EXT): form.h
reentr$(OBJ_EXT): gv.h
reentr$(OBJ_EXT): handy.h
reentr$(OBJ_EXT): hv.h
reentr$(OBJ_EXT): hv_func.h
reentr$(OBJ_EXT): hv_macro.h
reentr$(OBJ_EXT): inline.h
reentr$(OBJ_EXT): intrpvar.h
reentr$(OBJ_EXT): iperlsys.h
reentr$(OBJ_EXT): keywords.h
reentr$(OBJ_EXT): locale_table.h
reentr$(OBJ_EXT): mg.h
reentr$(OBJ_EXT): mg_vtable.h
reentr$(OBJ_EXT): mydtrace.h
reentr$(OBJ_EXT): nostdio.h
reentr$(OBJ_EXT): op.h
reentr$(OBJ_EXT): op_reg_common.h
reentr$(OBJ_EXT): opcode.h
reentr$(OBJ_EXT): opnames.h
reentr$(OBJ_EXT): overload.h
reentr$(OBJ_EXT): pad.h
reentr$(OBJ_EXT): parser.h
reentr$(OBJ_EXT): patchlevel.h
reentr$(OBJ_EXT): perl.h
reentr$(OBJ_EXT): perl_langinfo.h
reentr$(OBJ_EXT): perl_siphash.h
reentr$(OBJ_EXT): perlio.h
reentr$(OBJ_EXT): perlstatic.h
reentr$(OBJ_EXT): perlvars.h
reentr$(OBJ_EXT): perly.h
reentr$(OBJ_EXT): pp.h
reentr$(OBJ_EXT): pp_proto.h
reentr$(OBJ_EXT): proto.h
reentr$(OBJ_EXT): reentr.c
reentr$(OBJ_EXT): reentr.h
reentr$(OBJ_EXT): regcharclass.h
reentr$(OBJ_EXT): regexp.h
reentr$(OBJ_EXT): sbox32_hash.h
reentr$(OBJ_EXT): scope.h
reentr$(OBJ_EXT): scope_types.h
reentr$(OBJ_EXT): sv.h
reentr$(OBJ_EXT): sv_inline.h
reentr$(OBJ_EXT): thread.h
reentr$(OBJ_EXT): unicode_constants.h
reentr$(OBJ_EXT): unixish.h
reentr$(OBJ_EXT): utf8.h
reentr$(OBJ_EXT): util.h
reentr$(OBJ_EXT): warnings.h
reentr$(OBJ_EXT): zaphod32_hash.h
reentr$(OBJ_EXT): cflags
regcomp$(OBJ_EXT): CROSS_ROOT/include/alloca.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/assert.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/ctype.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/dirent.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/endian.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/errno.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/features.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/float.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/limits.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/locale.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/math.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/netdb.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/signal.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/stddef.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/stdint.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/stdio.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/string.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/strings.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/time.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/unistd.h
regcomp$(OBJ_EXT): CROSS_ROOT/include/wchar.h
regcomp$(OBJ_EXT): EXTERN.h
regcomp$(OBJ_EXT): av.h
regcomp$(OBJ_EXT): charclass_invlists.h
regcomp$(OBJ_EXT): config.h
regcomp$(OBJ_EXT): cop.h
regcomp$(OBJ_EXT): cv.h
regcomp$(OBJ_EXT): embed.h
regcomp$(OBJ_EXT): embedvar.h
regcomp$(OBJ_EXT): form.h
regcomp$(OBJ_EXT): gv.h
regcomp$(OBJ_EXT): handy.h
regcomp$(OBJ_EXT): hv.h
regcomp$(OBJ_EXT): hv_func.h
regcomp$(OBJ_EXT): hv_macro.h
regcomp$(OBJ_EXT): inline.h
regcomp$(OBJ_EXT): intrpvar.h
regcomp$(OBJ_EXT): invlist_inline.h
regcomp$(OBJ_EXT): iperlsys.h
regcomp$(OBJ_EXT): locale_table.h
regcomp$(OBJ_EXT): mg.h
regcomp$(OBJ_EXT): mg_vtable.h
regcomp$(OBJ_EXT): mydtrace.h
regcomp$(OBJ_EXT): nostdio.h
regcomp$(OBJ_EXT): op.h
regcomp$(OBJ_EXT): op_reg_common.h
regcomp$(OBJ_EXT): opcode.h
regcomp$(OBJ_EXT): opnames.h
regcomp$(OBJ_EXT): overload.h
regcomp$(OBJ_EXT): pad.h
regcomp$(OBJ_EXT): parser.h
regcomp$(OBJ_EXT): patchlevel.h
regcomp$(OBJ_EXT): perl.h
regcomp$(OBJ_EXT): perl_langinfo.h
regcomp$(OBJ_EXT): perl_siphash.h
regcomp$(OBJ_EXT): perlio.h
regcomp$(OBJ_EXT): perlstatic.h
regcomp$(OBJ_EXT): perlvars.h
regcomp$(OBJ_EXT): perly.h
regcomp$(OBJ_EXT): pp.h
regcomp$(OBJ_EXT): pp_proto.h
regcomp$(OBJ_EXT): proto.h
regcomp$(OBJ_EXT): regcharclass.h
regcomp$(OBJ_EXT): regcomp.c
regcomp$(OBJ_EXT): regcomp.h
regcomp$(OBJ_EXT): regcomp_internal.h
regcomp$(OBJ_EXT): regexp.h
regcomp$(OBJ_EXT): reginline.h
regcomp$(OBJ_EXT): regnodes.h
regcomp$(OBJ_EXT): sbox32_hash.h
regcomp$(OBJ_EXT): scope.h
regcomp$(OBJ_EXT): scope_types.h
regcomp$(OBJ_EXT): sv.h
regcomp$(OBJ_EXT): sv_inline.h
regcomp$(OBJ_EXT): thread.h
regcomp$(OBJ_EXT): unicode_constants.h
regcomp$(OBJ_EXT): unixish.h
regcomp$(OBJ_EXT): utf8.h
regcomp$(OBJ_EXT): util.h
regcomp$(OBJ_EXT): warnings.h
regcomp$(OBJ_EXT): zaphod32_hash.h
regcomp$(OBJ_EXT): cflags
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/alloca.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/assert.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/ctype.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/dirent.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/endian.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/errno.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/features.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/float.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/limits.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/locale.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/math.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/netdb.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/signal.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/stddef.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/stdint.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/stdio.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/string.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/strings.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/time.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/unistd.h
regcomp_debug$(OBJ_EXT): CROSS_ROOT/include/wchar.h
regcomp_debug$(OBJ_EXT): EXTERN.h
regcomp_debug$(OBJ_EXT): av.h
regcomp_debug$(OBJ_EXT): charclass_invlists.h
regcomp_debug$(OBJ_EXT): config.h
regcomp_debug$(OBJ_EXT): cop.h
regcomp_debug$(OBJ_EXT): cv.h
regcomp_debug$(OBJ_EXT): embed.h
regcomp_debug$(OBJ_EXT): embedvar.h
regcomp_debug$(OBJ_EXT): form.h
regcomp_debug$(OBJ_EXT): gv.h
regcomp_debug$(OBJ_EXT): handy.h
regcomp_debug$(OBJ_EXT): hv.h
regcomp_debug$(OBJ_EXT): hv_func.h
regcomp_debug$(OBJ_EXT): hv_macro.h
regcomp_debug$(OBJ_EXT): inline.h
regcomp_debug$(OBJ_EXT): intrpvar.h
regcomp_debug$(OBJ_EXT): invlist_inline.h
regcomp_debug$(OBJ_EXT): iperlsys.h
regcomp_debug$(OBJ_EXT): locale_table.h
regcomp_debug$(OBJ_EXT): mg.h
regcomp_debug$(OBJ_EXT): mg_vtable.h
regcomp_debug$(OBJ_EXT): mydtrace.h
regcomp_debug$(OBJ_EXT): nostdio.h
regcomp_debug$(OBJ_EXT): op.h
regcomp_debug$(OBJ_EXT): op_reg_common.h
regcomp_debug$(OBJ_EXT): opcode.h
regcomp_debug$(OBJ_EXT): opnames.h
regcomp_debug$(OBJ_EXT): overload.h
regcomp_debug$(OBJ_EXT): pad.h
regcomp_debug$(OBJ_EXT): parser.h
regcomp_debug$(OBJ_EXT): patchlevel.h
regcomp_debug$(OBJ_EXT): perl.h
regcomp_debug$(OBJ_EXT): perl_langinfo.h
regcomp_debug$(OBJ_EXT): perl_siphash.h
regcomp_debug$(OBJ_EXT): perlio.h
regcomp_debug$(OBJ_EXT): perlstatic.h
regcomp_debug$(OBJ_EXT): perlvars.h
regcomp_debug$(OBJ_EXT): perly.h
regcomp_debug$(OBJ_EXT): pp.h
regcomp_debug$(OBJ_EXT): pp_proto.h
regcomp_debug$(OBJ_EXT): proto.h
regcomp_debug$(OBJ_EXT): regcharclass.h
regcomp_debug$(OBJ_EXT): regcomp.h
regcomp_debug$(OBJ_EXT): regcomp_debug.c
regcomp_debug$(OBJ_EXT): regcomp_internal.h
regcomp_debug$(OBJ_EXT): regexp.h
regcomp_debug$(OBJ_EXT): reginline.h
regcomp_debug$(OBJ_EXT): regnodes.h
regcomp_debug$(OBJ_EXT): sbox32_hash.h
regcomp_debug$(OBJ_EXT): scope.h
regcomp_debug$(OBJ_EXT): scope_types.h
regcomp_debug$(OBJ_EXT): sv.h
regcomp_debug$(OBJ_EXT): sv_inline.h
regcomp_debug$(OBJ_EXT): thread.h
regcomp_debug$(OBJ_EXT): unicode_constants.h
regcomp_debug$(OBJ_EXT): unixish.h
regcomp_debug$(OBJ_EXT): utf8.h
regcomp_debug$(OBJ_EXT): util.h
regcomp_debug$(OBJ_EXT): warnings.h
regcomp_debug$(OBJ_EXT): zaphod32_hash.h
regcomp_debug$(OBJ_EXT): cflags
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/alloca.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/assert.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/ctype.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/dirent.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/endian.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/errno.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/features.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/float.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/limits.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/locale.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/math.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/netdb.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/signal.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/stddef.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/stdint.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/stdio.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/string.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/strings.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/time.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/unistd.h
regcomp_invlist$(OBJ_EXT): CROSS_ROOT/include/wchar.h
regcomp_invlist$(OBJ_EXT): EXTERN.h
regcomp_invlist$(OBJ_EXT): av.h
regcomp_invlist$(OBJ_EXT): charclass_invlists.h
regcomp_invlist$(OBJ_EXT): config.h
regcomp_invlist$(OBJ_EXT): cop.h
regcomp_invlist$(OBJ_EXT): cv.h
regcomp_invlist$(OBJ_EXT): embed.h
regcomp_invlist$(OBJ_EXT): embedvar.h
regcomp_invlist$(OBJ_EXT): form.h
regcomp_invlist$(OBJ_EXT): gv.h
regcomp_invlist$(OBJ_EXT): handy.h
regcomp_invlist$(OBJ_EXT): hv.h
regcomp_invlist$(OBJ_EXT): hv_func.h
regcomp_invlist$(OBJ_EXT): hv_macro.h
regcomp_invlist$(OBJ_EXT): inline.h
regcomp_invlist$(OBJ_EXT): intrpvar.h
regcomp_invlist$(OBJ_EXT): invlist_inline.h
regcomp_invlist$(OBJ_EXT): iperlsys.h
regcomp_invlist$(OBJ_EXT): locale_table.h
regcomp_invlist$(OBJ_EXT): mg.h
regcomp_invlist$(OBJ_EXT): mg_vtable.h
regcomp_invlist$(OBJ_EXT): mydtrace.h
regcomp_invlist$(OBJ_EXT): nostdio.h
regcomp_invlist$(OBJ_EXT): op.h
regcomp_invlist$(OBJ_EXT): op_reg_common.h
regcomp_invlist$(OBJ_EXT): opcode.h
regcomp_invlist$(OBJ_EXT): opnames.h
regcomp_invlist$(OBJ_EXT): overload.h
regcomp_invlist$(OBJ_EXT): pad.h
regcomp_invlist$(OBJ_EXT): parser.h
regcomp_invlist$(OBJ_EXT): patchlevel.h
regcomp_invlist$(OBJ_EXT): perl.h
regcomp_invlist$(OBJ_EXT): perl_langinfo.h
regcomp_invlist$(OBJ_EXT): perl_siphash.h
regcomp_invlist$(OBJ_EXT): perlio.h
regcomp_invlist$(OBJ_EXT): perlstatic.h
regcomp_invlist$(OBJ_EXT): perlvars.h
regcomp_invlist$(OBJ_EXT): perly.h
regcomp_invlist$(OBJ_EXT): pp.h
regcomp_invlist$(OBJ_EXT): pp_proto.h
regcomp_invlist$(OBJ_EXT): proto.h
regcomp_invlist$(OBJ_EXT): regcharclass.h
regcomp_invlist$(OBJ_EXT): regcomp.h
regcomp_invlist$(OBJ_EXT): regcomp_internal.h
regcomp_invlist$(OBJ_EXT): regcomp_invlist.c
regcomp_invlist$(OBJ_EXT): regexp.h
regcomp_invlist$(OBJ_EXT): reginline.h
regcomp_invlist$(OBJ_EXT): regnodes.h
regcomp_invlist$(OBJ_EXT): sbox32_hash.h
regcomp_invlist$(OBJ_EXT): scope.h
regcomp_invlist$(OBJ_EXT): scope_types.h
regcomp_invlist$(OBJ_EXT): sv.h
regcomp_invlist$(OBJ_EXT): sv_inline.h
regcomp_invlist$(OBJ_EXT): thread.h
regcomp_invlist$(OBJ_EXT): unicode_constants.h
regcomp_invlist$(OBJ_EXT): unixish.h
regcomp_invlist$(OBJ_EXT): utf8.h
regcomp_invlist$(OBJ_EXT): util.h
regcomp_invlist$(OBJ_EXT): warnings.h
regcomp_invlist$(OBJ_EXT): zaphod32_hash.h
regcomp_invlist$(OBJ_EXT): cflags
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/alloca.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/assert.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/ctype.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/dirent.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/endian.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/errno.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/features.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/float.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/limits.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/locale.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/math.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/netdb.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/signal.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/stddef.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/stdint.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/stdio.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/string.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/strings.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/time.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/unistd.h
regcomp_study$(OBJ_EXT): CROSS_ROOT/include/wchar.h
regcomp_study$(OBJ_EXT): EXTERN.h
regcomp_study$(OBJ_EXT): av.h
regcomp_study$(OBJ_EXT): charclass_invlists.h
regcomp_study$(OBJ_EXT): config.h
regcomp_study$(OBJ_EXT): cop.h
regcomp_study$(OBJ_EXT): cv.h
regcomp_study$(OBJ_EXT): embed.h
regcomp_study$(OBJ_EXT): embedvar.h
regcomp_study$(OBJ_EXT): form.h
regcomp_study$(OBJ_EXT): gv.h
regcomp_study$(OBJ_EXT): handy.h
regcomp_study$(OBJ_EXT): hv.h
regcomp_study$(OBJ_EXT): hv_func.h
regcomp_study$(OBJ_EXT): hv_macro.h
regcomp_study$(OBJ_EXT): inline.h
regcomp_study$(OBJ_EXT): intrpvar.h
regcomp_study$(OBJ_EXT): invlist_inline.h
regcomp_study$(OBJ_EXT): iperlsys.h
regcomp_study$(OBJ_EXT): locale_table.h
regcomp_study$(OBJ_EXT): mg.h
regcomp_study$(OBJ_EXT): mg_vtable.h
regcomp_study$(OBJ_EXT): mydtrace.h
regcomp_study$(OBJ_EXT): nostdio.h
regcomp_study$(OBJ_EXT): op.h
regcomp_study$(OBJ_EXT): op_reg_common.h
regcomp_study$(OBJ_EXT): opcode.h
regcomp_study$(OBJ_EXT): opnames.h
regcomp_study$(OBJ_EXT): overload.h
regcomp_study$(OBJ_EXT): pad.h
regcomp_study$(OBJ_EXT): parser.h
regcomp_study$(OBJ_EXT): patchlevel.h
regcomp_study$(OBJ_EXT): perl.h
regcomp_study$(OBJ_EXT): perl_langinfo.h
regcomp_study$(OBJ_EXT): perl_siphash.h
regcomp_study$(OBJ_EXT): perlio.h
regcomp_study$(OBJ_EXT): perlstatic.h
regcomp_study$(OBJ_EXT): perlvars.h
regcomp_study$(OBJ_EXT): perly.h
regcomp_study$(OBJ_EXT): pp.h
regcomp_study$(OBJ_EXT): pp_proto.h
regcomp_study$(OBJ_EXT): proto.h
regcomp_study$(OBJ_EXT): regcharclass.h
regcomp_study$(OBJ_EXT): regcomp.h
regcomp_study$(OBJ_EXT): regcomp_internal.h
regcomp_study$(OBJ_EXT): regcomp_study.c
regcomp_study$(OBJ_EXT): regexp.h
regcomp_study$(OBJ_EXT): reginline.h
regcomp_study$(OBJ_EXT): regnodes.h
regcomp_study$(OBJ_EXT): sbox32_hash.h
regcomp_study$(OBJ_EXT): scope.h
regcomp_study$(OBJ_EXT): scope_types.h
regcomp_study$(OBJ_EXT): sv.h
regcomp_study$(OBJ_EXT): sv_inline.h
regcomp_study$(OBJ_EXT): thread.h
regcomp_study$(OBJ_EXT): unicode_constants.h
regcomp_study$(OBJ_EXT): unixish.h
regcomp_study$(OBJ_EXT): utf8.h
regcomp_study$(OBJ_EXT): util.h
regcomp_study$(OBJ_EXT): warnings.h
regcomp_study$(OBJ_EXT): zaphod32_hash.h
regcomp_study$(OBJ_EXT): cflags
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/alloca.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/assert.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/ctype.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/dirent.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/endian.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/errno.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/features.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/float.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/limits.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/locale.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/math.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/netdb.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/signal.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/stddef.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/stdint.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/stdio.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/string.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/strings.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/time.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/unistd.h
regcomp_trie$(OBJ_EXT): CROSS_ROOT/include/wchar.h
regcomp_trie$(OBJ_EXT): EXTERN.h
regcomp_trie$(OBJ_EXT): av.h
regcomp_trie$(OBJ_EXT): charclass_invlists.h
regcomp_trie$(OBJ_EXT): config.h
regcomp_trie$(OBJ_EXT): cop.h
regcomp_trie$(OBJ_EXT): cv.h
regcomp_trie$(OBJ_EXT): embed.h
regcomp_trie$(OBJ_EXT): embedvar.h
regcomp_trie$(OBJ_EXT): form.h
regcomp_trie$(OBJ_EXT): gv.h
regcomp_trie$(OBJ_EXT): handy.h
regcomp_trie$(OBJ_EXT): hv.h
regcomp_trie$(OBJ_EXT): hv_func.h
regcomp_trie$(OBJ_EXT): hv_macro.h
regcomp_trie$(OBJ_EXT): inline.h
regcomp_trie$(OBJ_EXT): intrpvar.h
regcomp_trie$(OBJ_EXT): invlist_inline.h
regcomp_trie$(OBJ_EXT): iperlsys.h
regcomp_trie$(OBJ_EXT): locale_table.h
regcomp_trie$(OBJ_EXT): mg.h
regcomp_trie$(OBJ_EXT): mg_vtable.h
regcomp_trie$(OBJ_EXT): mydtrace.h
regcomp_trie$(OBJ_EXT): nostdio.h
regcomp_trie$(OBJ_EXT): op.h
regcomp_trie$(OBJ_EXT): op_reg_common.h
regcomp_trie$(OBJ_EXT): opcode.h
regcomp_trie$(OBJ_EXT): opnames.h
regcomp_trie$(OBJ_EXT): overload.h
regcomp_trie$(OBJ_EXT): pad.h
regcomp_trie$(OBJ_EXT): parser.h
regcomp_trie$(OBJ_EXT): patchlevel.h
regcomp_trie$(OBJ_EXT): perl.h
regcomp_trie$(OBJ_EXT): perl_langinfo.h
regcomp_trie$(OBJ_EXT): perl_siphash.h
regcomp_trie$(OBJ_EXT): perlio.h
regcomp_trie$(OBJ_EXT): perlstatic.h
regcomp_trie$(OBJ_EXT): perlvars.h
regcomp_trie$(OBJ_EXT): perly.h
regcomp_trie$(OBJ_EXT): pp.h
regcomp_trie$(OBJ_EXT): pp_proto.h
regcomp_trie$(OBJ_EXT): proto.h
regcomp_trie$(OBJ_EXT): regcharclass.h
regcomp_trie$(OBJ_EXT): regcomp.h
regcomp_trie$(OBJ_EXT): regcomp_internal.h
regcomp_trie$(OBJ_EXT): regcomp_trie.c
regcomp_trie$(OBJ_EXT): regexp.h
regcomp_trie$(OBJ_EXT): reginline.h
regcomp_trie$(OBJ_EXT): regnodes.h
regcomp_trie$(OBJ_EXT): sbox32_hash.h
regcomp_trie$(OBJ_EXT): scope.h
regcomp_trie$(OBJ_EXT): scope_types.h
regcomp_trie$(OBJ_EXT): sv.h
regcomp_trie$(OBJ_EXT): sv_inline.h
regcomp_trie$(OBJ_EXT): thread.h
regcomp_trie$(OBJ_EXT): unicode_constants.h
regcomp_trie$(OBJ_EXT): unixish.h
regcomp_trie$(OBJ_EXT): utf8.h
regcomp_trie$(OBJ_EXT): util.h
regcomp_trie$(OBJ_EXT): warnings.h
regcomp_trie$(OBJ_EXT): zaphod32_hash.h
regcomp_trie$(OBJ_EXT): cflags
regexec$(OBJ_EXT): CROSS_ROOT/include/alloca.h
regexec$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
regexec$(OBJ_EXT): CROSS_ROOT/include/assert.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
regexec$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
regexec$(OBJ_EXT): CROSS_ROOT/include/ctype.h
regexec$(OBJ_EXT): CROSS_ROOT/include/dirent.h
regexec$(OBJ_EXT): CROSS_ROOT/include/endian.h
regexec$(OBJ_EXT): CROSS_ROOT/include/errno.h
regexec$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
regexec$(OBJ_EXT): CROSS_ROOT/include/features.h
regexec$(OBJ_EXT): CROSS_ROOT/include/float.h
regexec$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
regexec$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
regexec$(OBJ_EXT): CROSS_ROOT/include/limits.h
regexec$(OBJ_EXT): CROSS_ROOT/include/locale.h
regexec$(OBJ_EXT): CROSS_ROOT/include/math.h
regexec$(OBJ_EXT): CROSS_ROOT/include/netdb.h
regexec$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
regexec$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
regexec$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
regexec$(OBJ_EXT): CROSS_ROOT/include/signal.h
regexec$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
regexec$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
regexec$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
regexec$(OBJ_EXT): CROSS_ROOT/include/stddef.h
regexec$(OBJ_EXT): CROSS_ROOT/include/stdint.h
regexec$(OBJ_EXT): CROSS_ROOT/include/stdio.h
regexec$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
regexec$(OBJ_EXT): CROSS_ROOT/include/string.h
regexec$(OBJ_EXT): CROSS_ROOT/include/strings.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
regexec$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
regexec$(OBJ_EXT): CROSS_ROOT/include/time.h
regexec$(OBJ_EXT): CROSS_ROOT/include/unistd.h
regexec$(OBJ_EXT): CROSS_ROOT/include/wchar.h
regexec$(OBJ_EXT): EXTERN.h
regexec$(OBJ_EXT): av.h
regexec$(OBJ_EXT): charclass_invlists.h
regexec$(OBJ_EXT): config.h
regexec$(OBJ_EXT): cop.h
regexec$(OBJ_EXT): cv.h
regexec$(OBJ_EXT): embed.h
regexec$(OBJ_EXT): embedvar.h
regexec$(OBJ_EXT): form.h
regexec$(OBJ_EXT): gv.h
regexec$(OBJ_EXT): handy.h
regexec$(OBJ_EXT): hv.h
regexec$(OBJ_EXT): hv_func.h
regexec$(OBJ_EXT): hv_macro.h
regexec$(OBJ_EXT): inline.h
regexec$(OBJ_EXT): intrpvar.h
regexec$(OBJ_EXT): invlist_inline.h
regexec$(OBJ_EXT): iperlsys.h
regexec$(OBJ_EXT): locale_table.h
regexec$(OBJ_EXT): mg.h
regexec$(OBJ_EXT): mg_vtable.h
regexec$(OBJ_EXT): mydtrace.h
regexec$(OBJ_EXT): nostdio.h
regexec$(OBJ_EXT): op.h
regexec$(OBJ_EXT): op_reg_common.h
regexec$(OBJ_EXT): opcode.h
regexec$(OBJ_EXT): opnames.h
regexec$(OBJ_EXT): overload.h
regexec$(OBJ_EXT): pad.h
regexec$(OBJ_EXT): parser.h
regexec$(OBJ_EXT): patchlevel.h
regexec$(OBJ_EXT): perl.h
regexec$(OBJ_EXT): perl_langinfo.h
regexec$(OBJ_EXT): perl_siphash.h
regexec$(OBJ_EXT): perlio.h
regexec$(OBJ_EXT): perlstatic.h
regexec$(OBJ_EXT): perlvars.h
regexec$(OBJ_EXT): perly.h
regexec$(OBJ_EXT): pp.h
regexec$(OBJ_EXT): pp_proto.h
regexec$(OBJ_EXT): proto.h
regexec$(OBJ_EXT): regcharclass.h
regexec$(OBJ_EXT): regcomp.h
regexec$(OBJ_EXT): regexec.c
regexec$(OBJ_EXT): regexp.h
regexec$(OBJ_EXT): reginline.h
regexec$(OBJ_EXT): regnodes.h
regexec$(OBJ_EXT): sbox32_hash.h
regexec$(OBJ_EXT): scope.h
regexec$(OBJ_EXT): scope_types.h
regexec$(OBJ_EXT): sv.h
regexec$(OBJ_EXT): sv_inline.h
regexec$(OBJ_EXT): thread.h
regexec$(OBJ_EXT): unicode_constants.h
regexec$(OBJ_EXT): unixish.h
regexec$(OBJ_EXT): utf8.h
regexec$(OBJ_EXT): util.h
regexec$(OBJ_EXT): warnings.h
regexec$(OBJ_EXT): zaphod32_hash.h
regexec$(OBJ_EXT): cflags
run$(OBJ_EXT): CROSS_ROOT/include/alloca.h
run$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
run$(OBJ_EXT): CROSS_ROOT/include/assert.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
run$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
run$(OBJ_EXT): CROSS_ROOT/include/ctype.h
run$(OBJ_EXT): CROSS_ROOT/include/dirent.h
run$(OBJ_EXT): CROSS_ROOT/include/endian.h
run$(OBJ_EXT): CROSS_ROOT/include/errno.h
run$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
run$(OBJ_EXT): CROSS_ROOT/include/features.h
run$(OBJ_EXT): CROSS_ROOT/include/float.h
run$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
run$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
run$(OBJ_EXT): CROSS_ROOT/include/limits.h
run$(OBJ_EXT): CROSS_ROOT/include/locale.h
run$(OBJ_EXT): CROSS_ROOT/include/math.h
run$(OBJ_EXT): CROSS_ROOT/include/netdb.h
run$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
run$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
run$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
run$(OBJ_EXT): CROSS_ROOT/include/signal.h
run$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
run$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
run$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
run$(OBJ_EXT): CROSS_ROOT/include/stddef.h
run$(OBJ_EXT): CROSS_ROOT/include/stdint.h
run$(OBJ_EXT): CROSS_ROOT/include/stdio.h
run$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
run$(OBJ_EXT): CROSS_ROOT/include/string.h
run$(OBJ_EXT): CROSS_ROOT/include/strings.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
run$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
run$(OBJ_EXT): CROSS_ROOT/include/time.h
run$(OBJ_EXT): CROSS_ROOT/include/unistd.h
run$(OBJ_EXT): CROSS_ROOT/include/wchar.h
run$(OBJ_EXT): EXTERN.h
run$(OBJ_EXT): av.h
run$(OBJ_EXT): charclass_invlists.h
run$(OBJ_EXT): config.h
run$(OBJ_EXT): cop.h
run$(OBJ_EXT): cv.h
run$(OBJ_EXT): embed.h
run$(OBJ_EXT): embedvar.h
run$(OBJ_EXT): form.h
run$(OBJ_EXT): gv.h
run$(OBJ_EXT): handy.h
run$(OBJ_EXT): hv.h
run$(OBJ_EXT): hv_func.h
run$(OBJ_EXT): hv_macro.h
run$(OBJ_EXT): inline.h
run$(OBJ_EXT): intrpvar.h
run$(OBJ_EXT): iperlsys.h
run$(OBJ_EXT): locale_table.h
run$(OBJ_EXT): mg.h
run$(OBJ_EXT): mg_vtable.h
run$(OBJ_EXT): mydtrace.h
run$(OBJ_EXT): nostdio.h
run$(OBJ_EXT): op.h
run$(OBJ_EXT): op_reg_common.h
run$(OBJ_EXT): opcode.h
run$(OBJ_EXT): opnames.h
run$(OBJ_EXT): overload.h
run$(OBJ_EXT): pad.h
run$(OBJ_EXT): parser.h
run$(OBJ_EXT): patchlevel.h
run$(OBJ_EXT): perl.h
run$(OBJ_EXT): perl_langinfo.h
run$(OBJ_EXT): perl_siphash.h
run$(OBJ_EXT): perlio.h
run$(OBJ_EXT): perlstatic.h
run$(OBJ_EXT): perlvars.h
run$(OBJ_EXT): perly.h
run$(OBJ_EXT): pp.h
run$(OBJ_EXT): pp_proto.h
run$(OBJ_EXT): proto.h
run$(OBJ_EXT): regcharclass.h
run$(OBJ_EXT): regexp.h
run$(OBJ_EXT): run.c
run$(OBJ_EXT): sbox32_hash.h
run$(OBJ_EXT): scope.h
run$(OBJ_EXT): scope_types.h
run$(OBJ_EXT): sv.h
run$(OBJ_EXT): sv_inline.h
run$(OBJ_EXT): thread.h
run$(OBJ_EXT): unicode_constants.h
run$(OBJ_EXT): unixish.h
run$(OBJ_EXT): utf8.h
run$(OBJ_EXT): util.h
run$(OBJ_EXT): warnings.h
run$(OBJ_EXT): zaphod32_hash.h
run$(OBJ_EXT): cflags
scope$(OBJ_EXT): CROSS_ROOT/include/alloca.h
scope$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
scope$(OBJ_EXT): CROSS_ROOT/include/assert.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
scope$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
scope$(OBJ_EXT): CROSS_ROOT/include/ctype.h
scope$(OBJ_EXT): CROSS_ROOT/include/dirent.h
scope$(OBJ_EXT): CROSS_ROOT/include/endian.h
scope$(OBJ_EXT): CROSS_ROOT/include/errno.h
scope$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
scope$(OBJ_EXT): CROSS_ROOT/include/features.h
scope$(OBJ_EXT): CROSS_ROOT/include/float.h
scope$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
scope$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
scope$(OBJ_EXT): CROSS_ROOT/include/limits.h
scope$(OBJ_EXT): CROSS_ROOT/include/locale.h
scope$(OBJ_EXT): CROSS_ROOT/include/math.h
scope$(OBJ_EXT): CROSS_ROOT/include/netdb.h
scope$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
scope$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
scope$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
scope$(OBJ_EXT): CROSS_ROOT/include/signal.h
scope$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
scope$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
scope$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
scope$(OBJ_EXT): CROSS_ROOT/include/stddef.h
scope$(OBJ_EXT): CROSS_ROOT/include/stdint.h
scope$(OBJ_EXT): CROSS_ROOT/include/stdio.h
scope$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
scope$(OBJ_EXT): CROSS_ROOT/include/string.h
scope$(OBJ_EXT): CROSS_ROOT/include/strings.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
scope$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
scope$(OBJ_EXT): CROSS_ROOT/include/time.h
scope$(OBJ_EXT): CROSS_ROOT/include/unistd.h
scope$(OBJ_EXT): CROSS_ROOT/include/wchar.h
scope$(OBJ_EXT): EXTERN.h
scope$(OBJ_EXT): av.h
scope$(OBJ_EXT): charclass_invlists.h
scope$(OBJ_EXT): config.h
scope$(OBJ_EXT): cop.h
scope$(OBJ_EXT): cv.h
scope$(OBJ_EXT): embed.h
scope$(OBJ_EXT): embedvar.h
scope$(OBJ_EXT): feature.h
scope$(OBJ_EXT): form.h
scope$(OBJ_EXT): gv.h
scope$(OBJ_EXT): handy.h
scope$(OBJ_EXT): hv.h
scope$(OBJ_EXT): hv_func.h
scope$(OBJ_EXT): hv_macro.h
scope$(OBJ_EXT): inline.h
scope$(OBJ_EXT): intrpvar.h
scope$(OBJ_EXT): iperlsys.h
scope$(OBJ_EXT): locale_table.h
scope$(OBJ_EXT): mg.h
scope$(OBJ_EXT): mg_vtable.h
scope$(OBJ_EXT): mydtrace.h
scope$(OBJ_EXT): nostdio.h
scope$(OBJ_EXT): op.h
scope$(OBJ_EXT): op_reg_common.h
scope$(OBJ_EXT): opcode.h
scope$(OBJ_EXT): opnames.h
scope$(OBJ_EXT): overload.h
scope$(OBJ_EXT): pad.h
scope$(OBJ_EXT): parser.h
scope$(OBJ_EXT): patchlevel.h
scope$(OBJ_EXT): perl.h
scope$(OBJ_EXT): perl_langinfo.h
scope$(OBJ_EXT): perl_siphash.h
scope$(OBJ_EXT): perlio.h
scope$(OBJ_EXT): perlstatic.h
scope$(OBJ_EXT): perlvars.h
scope$(OBJ_EXT): perly.h
scope$(OBJ_EXT): pp.h
scope$(OBJ_EXT): pp_proto.h
scope$(OBJ_EXT): proto.h
scope$(OBJ_EXT): regcharclass.h
scope$(OBJ_EXT): regexp.h
scope$(OBJ_EXT): sbox32_hash.h
scope$(OBJ_EXT): scope.c
scope$(OBJ_EXT): scope.h
scope$(OBJ_EXT): scope_types.h
scope$(OBJ_EXT): sv.h
scope$(OBJ_EXT): sv_inline.h
scope$(OBJ_EXT): thread.h
scope$(OBJ_EXT): unicode_constants.h
scope$(OBJ_EXT): unixish.h
scope$(OBJ_EXT): utf8.h
scope$(OBJ_EXT): util.h
scope$(OBJ_EXT): warnings.h
scope$(OBJ_EXT): zaphod32_hash.h
scope$(OBJ_EXT): cflags
sv$(OBJ_EXT): CROSS_ROOT/include/alloca.h
sv$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
sv$(OBJ_EXT): CROSS_ROOT/include/assert.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
sv$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
sv$(OBJ_EXT): CROSS_ROOT/include/ctype.h
sv$(OBJ_EXT): CROSS_ROOT/include/dirent.h
sv$(OBJ_EXT): CROSS_ROOT/include/endian.h
sv$(OBJ_EXT): CROSS_ROOT/include/errno.h
sv$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
sv$(OBJ_EXT): CROSS_ROOT/include/features.h
sv$(OBJ_EXT): CROSS_ROOT/include/float.h
sv$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
sv$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
sv$(OBJ_EXT): CROSS_ROOT/include/limits.h
sv$(OBJ_EXT): CROSS_ROOT/include/locale.h
sv$(OBJ_EXT): CROSS_ROOT/include/math.h
sv$(OBJ_EXT): CROSS_ROOT/include/netdb.h
sv$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
sv$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
sv$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
sv$(OBJ_EXT): CROSS_ROOT/include/signal.h
sv$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
sv$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
sv$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
sv$(OBJ_EXT): CROSS_ROOT/include/stddef.h
sv$(OBJ_EXT): CROSS_ROOT/include/stdint.h
sv$(OBJ_EXT): CROSS_ROOT/include/stdio.h
sv$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
sv$(OBJ_EXT): CROSS_ROOT/include/string.h
sv$(OBJ_EXT): CROSS_ROOT/include/strings.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
sv$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
sv$(OBJ_EXT): CROSS_ROOT/include/time.h
sv$(OBJ_EXT): CROSS_ROOT/include/unistd.h
sv$(OBJ_EXT): CROSS_ROOT/include/wchar.h
sv$(OBJ_EXT): EXTERN.h
sv$(OBJ_EXT): av.h
sv$(OBJ_EXT): charclass_invlists.h
sv$(OBJ_EXT): config.h
sv$(OBJ_EXT): cop.h
sv$(OBJ_EXT): cv.h
sv$(OBJ_EXT): embed.h
sv$(OBJ_EXT): embedvar.h
sv$(OBJ_EXT): form.h
sv$(OBJ_EXT): gv.h
sv$(OBJ_EXT): handy.h
sv$(OBJ_EXT): hv.h
sv$(OBJ_EXT): hv_func.h
sv$(OBJ_EXT): hv_macro.h
sv$(OBJ_EXT): inline.h
sv$(OBJ_EXT): intrpvar.h
sv$(OBJ_EXT): iperlsys.h
sv$(OBJ_EXT): locale_table.h
sv$(OBJ_EXT): mg.h
sv$(OBJ_EXT): mg_vtable.h
sv$(OBJ_EXT): mydtrace.h
sv$(OBJ_EXT): nostdio.h
sv$(OBJ_EXT): op.h
sv$(OBJ_EXT): op_reg_common.h
sv$(OBJ_EXT): opcode.h
sv$(OBJ_EXT): opnames.h
sv$(OBJ_EXT): overload.h
sv$(OBJ_EXT): pad.h
sv$(OBJ_EXT): parser.h
sv$(OBJ_EXT): patchlevel.h
sv$(OBJ_EXT): perl.h
sv$(OBJ_EXT): perl_langinfo.h
sv$(OBJ_EXT): perl_siphash.h
sv$(OBJ_EXT): perlio.h
sv$(OBJ_EXT): perlstatic.h
sv$(OBJ_EXT): perlvars.h
sv$(OBJ_EXT): perly.h
sv$(OBJ_EXT): pp.h
sv$(OBJ_EXT): pp_proto.h
sv$(OBJ_EXT): proto.h
sv$(OBJ_EXT): regcharclass.h
sv$(OBJ_EXT): regcomp.h
sv$(OBJ_EXT): regexp.h
sv$(OBJ_EXT): regnodes.h
sv$(OBJ_EXT): sbox32_hash.h
sv$(OBJ_EXT): scope.h
sv$(OBJ_EXT): scope_types.h
sv$(OBJ_EXT): sv.c
sv$(OBJ_EXT): sv.h
sv$(OBJ_EXT): sv_inline.h
sv$(OBJ_EXT): thread.h
sv$(OBJ_EXT): unicode_constants.h
sv$(OBJ_EXT): unixish.h
sv$(OBJ_EXT): utf8.h
sv$(OBJ_EXT): util.h
sv$(OBJ_EXT): warnings.h
sv$(OBJ_EXT): zaphod32_hash.h
sv$(OBJ_EXT): cflags
taint$(OBJ_EXT): CROSS_ROOT/include/alloca.h
taint$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
taint$(OBJ_EXT): CROSS_ROOT/include/assert.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
taint$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
taint$(OBJ_EXT): CROSS_ROOT/include/ctype.h
taint$(OBJ_EXT): CROSS_ROOT/include/dirent.h
taint$(OBJ_EXT): CROSS_ROOT/include/endian.h
taint$(OBJ_EXT): CROSS_ROOT/include/errno.h
taint$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
taint$(OBJ_EXT): CROSS_ROOT/include/features.h
taint$(OBJ_EXT): CROSS_ROOT/include/float.h
taint$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
taint$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
taint$(OBJ_EXT): CROSS_ROOT/include/limits.h
taint$(OBJ_EXT): CROSS_ROOT/include/locale.h
taint$(OBJ_EXT): CROSS_ROOT/include/math.h
taint$(OBJ_EXT): CROSS_ROOT/include/netdb.h
taint$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
taint$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
taint$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
taint$(OBJ_EXT): CROSS_ROOT/include/signal.h
taint$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
taint$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
taint$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
taint$(OBJ_EXT): CROSS_ROOT/include/stddef.h
taint$(OBJ_EXT): CROSS_ROOT/include/stdint.h
taint$(OBJ_EXT): CROSS_ROOT/include/stdio.h
taint$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
taint$(OBJ_EXT): CROSS_ROOT/include/string.h
taint$(OBJ_EXT): CROSS_ROOT/include/strings.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
taint$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
taint$(OBJ_EXT): CROSS_ROOT/include/time.h
taint$(OBJ_EXT): CROSS_ROOT/include/unistd.h
taint$(OBJ_EXT): CROSS_ROOT/include/wchar.h
taint$(OBJ_EXT): EXTERN.h
taint$(OBJ_EXT): av.h
taint$(OBJ_EXT): charclass_invlists.h
taint$(OBJ_EXT): config.h
taint$(OBJ_EXT): cop.h
taint$(OBJ_EXT): cv.h
taint$(OBJ_EXT): embed.h
taint$(OBJ_EXT): embedvar.h
taint$(OBJ_EXT): form.h
taint$(OBJ_EXT): gv.h
taint$(OBJ_EXT): handy.h
taint$(OBJ_EXT): hv.h
taint$(OBJ_EXT): hv_func.h
taint$(OBJ_EXT): hv_macro.h
taint$(OBJ_EXT): inline.h
taint$(OBJ_EXT): intrpvar.h
taint$(OBJ_EXT): iperlsys.h
taint$(OBJ_EXT): locale_table.h
taint$(OBJ_EXT): mg.h
taint$(OBJ_EXT): mg_vtable.h
taint$(OBJ_EXT): mydtrace.h
taint$(OBJ_EXT): nostdio.h
taint$(OBJ_EXT): op.h
taint$(OBJ_EXT): op_reg_common.h
taint$(OBJ_EXT): opcode.h
taint$(OBJ_EXT): opnames.h
taint$(OBJ_EXT): overload.h
taint$(OBJ_EXT): pad.h
taint$(OBJ_EXT): parser.h
taint$(OBJ_EXT): patchlevel.h
taint$(OBJ_EXT): perl.h
taint$(OBJ_EXT): perl_langinfo.h
taint$(OBJ_EXT): perl_siphash.h
taint$(OBJ_EXT): perlio.h
taint$(OBJ_EXT): perlstatic.h
taint$(OBJ_EXT): perlvars.h
taint$(OBJ_EXT): perly.h
taint$(OBJ_EXT): pp.h
taint$(OBJ_EXT): pp_proto.h
taint$(OBJ_EXT): proto.h
taint$(OBJ_EXT): regcharclass.h
taint$(OBJ_EXT): regexp.h
taint$(OBJ_EXT): sbox32_hash.h
taint$(OBJ_EXT): scope.h
taint$(OBJ_EXT): scope_types.h
taint$(OBJ_EXT): sv.h
taint$(OBJ_EXT): sv_inline.h
taint$(OBJ_EXT): taint.c
taint$(OBJ_EXT): thread.h
taint$(OBJ_EXT): unicode_constants.h
taint$(OBJ_EXT): unixish.h
taint$(OBJ_EXT): utf8.h
taint$(OBJ_EXT): util.h
taint$(OBJ_EXT): warnings.h
taint$(OBJ_EXT): zaphod32_hash.h
taint$(OBJ_EXT): cflags
time64$(OBJ_EXT): CROSS_ROOT/include/alloca.h
time64$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
time64$(OBJ_EXT): CROSS_ROOT/include/assert.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
time64$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
time64$(OBJ_EXT): CROSS_ROOT/include/ctype.h
time64$(OBJ_EXT): CROSS_ROOT/include/dirent.h
time64$(OBJ_EXT): CROSS_ROOT/include/endian.h
time64$(OBJ_EXT): CROSS_ROOT/include/errno.h
time64$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
time64$(OBJ_EXT): CROSS_ROOT/include/features.h
time64$(OBJ_EXT): CROSS_ROOT/include/float.h
time64$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
time64$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
time64$(OBJ_EXT): CROSS_ROOT/include/limits.h
time64$(OBJ_EXT): CROSS_ROOT/include/locale.h
time64$(OBJ_EXT): CROSS_ROOT/include/math.h
time64$(OBJ_EXT): CROSS_ROOT/include/netdb.h
time64$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
time64$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
time64$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
time64$(OBJ_EXT): CROSS_ROOT/include/signal.h
time64$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
time64$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
time64$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
time64$(OBJ_EXT): CROSS_ROOT/include/stddef.h
time64$(OBJ_EXT): CROSS_ROOT/include/stdint.h
time64$(OBJ_EXT): CROSS_ROOT/include/stdio.h
time64$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
time64$(OBJ_EXT): CROSS_ROOT/include/string.h
time64$(OBJ_EXT): CROSS_ROOT/include/strings.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
time64$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
time64$(OBJ_EXT): CROSS_ROOT/include/time.h
time64$(OBJ_EXT): CROSS_ROOT/include/unistd.h
time64$(OBJ_EXT): CROSS_ROOT/include/wchar.h
time64$(OBJ_EXT): EXTERN.h
time64$(OBJ_EXT): av.h
time64$(OBJ_EXT): charclass_invlists.h
time64$(OBJ_EXT): config.h
time64$(OBJ_EXT): cop.h
time64$(OBJ_EXT): cv.h
time64$(OBJ_EXT): embed.h
time64$(OBJ_EXT): embedvar.h
time64$(OBJ_EXT): form.h
time64$(OBJ_EXT): gv.h
time64$(OBJ_EXT): handy.h
time64$(OBJ_EXT): hv.h
time64$(OBJ_EXT): hv_func.h
time64$(OBJ_EXT): hv_macro.h
time64$(OBJ_EXT): inline.h
time64$(OBJ_EXT): intrpvar.h
time64$(OBJ_EXT): iperlsys.h
time64$(OBJ_EXT): locale_table.h
time64$(OBJ_EXT): mg.h
time64$(OBJ_EXT): mg_vtable.h
time64$(OBJ_EXT): mydtrace.h
time64$(OBJ_EXT): nostdio.h
time64$(OBJ_EXT): op.h
time64$(OBJ_EXT): op_reg_common.h
time64$(OBJ_EXT): opcode.h
time64$(OBJ_EXT): opnames.h
time64$(OBJ_EXT): overload.h
time64$(OBJ_EXT): pad.h
time64$(OBJ_EXT): parser.h
time64$(OBJ_EXT): patchlevel.h
time64$(OBJ_EXT): perl.h
time64$(OBJ_EXT): perl_langinfo.h
time64$(OBJ_EXT): perl_siphash.h
time64$(OBJ_EXT): perlio.h
time64$(OBJ_EXT): perlstatic.h
time64$(OBJ_EXT): perlvars.h
time64$(OBJ_EXT): perly.h
time64$(OBJ_EXT): pp.h
time64$(OBJ_EXT): pp_proto.h
time64$(OBJ_EXT): proto.h
time64$(OBJ_EXT): reentr.h
time64$(OBJ_EXT): regcharclass.h
time64$(OBJ_EXT): regexp.h
time64$(OBJ_EXT): sbox32_hash.h
time64$(OBJ_EXT): scope.h
time64$(OBJ_EXT): scope_types.h
time64$(OBJ_EXT): sv.h
time64$(OBJ_EXT): sv_inline.h
time64$(OBJ_EXT): thread.h
time64$(OBJ_EXT): time64.c
time64$(OBJ_EXT): time64.h
time64$(OBJ_EXT): time64_config.h
time64$(OBJ_EXT): unicode_constants.h
time64$(OBJ_EXT): unixish.h
time64$(OBJ_EXT): utf8.h
time64$(OBJ_EXT): util.h
time64$(OBJ_EXT): warnings.h
time64$(OBJ_EXT): zaphod32_hash.h
time64$(OBJ_EXT): cflags
toke$(OBJ_EXT): CROSS_ROOT/include/alloca.h
toke$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
toke$(OBJ_EXT): CROSS_ROOT/include/assert.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
toke$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
toke$(OBJ_EXT): CROSS_ROOT/include/ctype.h
toke$(OBJ_EXT): CROSS_ROOT/include/dirent.h
toke$(OBJ_EXT): CROSS_ROOT/include/endian.h
toke$(OBJ_EXT): CROSS_ROOT/include/errno.h
toke$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
toke$(OBJ_EXT): CROSS_ROOT/include/features.h
toke$(OBJ_EXT): CROSS_ROOT/include/float.h
toke$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
toke$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
toke$(OBJ_EXT): CROSS_ROOT/include/limits.h
toke$(OBJ_EXT): CROSS_ROOT/include/locale.h
toke$(OBJ_EXT): CROSS_ROOT/include/math.h
toke$(OBJ_EXT): CROSS_ROOT/include/netdb.h
toke$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
toke$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
toke$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
toke$(OBJ_EXT): CROSS_ROOT/include/signal.h
toke$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
toke$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
toke$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
toke$(OBJ_EXT): CROSS_ROOT/include/stddef.h
toke$(OBJ_EXT): CROSS_ROOT/include/stdint.h
toke$(OBJ_EXT): CROSS_ROOT/include/stdio.h
toke$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
toke$(OBJ_EXT): CROSS_ROOT/include/string.h
toke$(OBJ_EXT): CROSS_ROOT/include/strings.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
toke$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
toke$(OBJ_EXT): CROSS_ROOT/include/time.h
toke$(OBJ_EXT): CROSS_ROOT/include/unistd.h
toke$(OBJ_EXT): CROSS_ROOT/include/wchar.h
toke$(OBJ_EXT): EXTERN.h
toke$(OBJ_EXT): av.h
toke$(OBJ_EXT): charclass_invlists.h
toke$(OBJ_EXT): config.h
toke$(OBJ_EXT): cop.h
toke$(OBJ_EXT): cv.h
toke$(OBJ_EXT): embed.h
toke$(OBJ_EXT): embedvar.h
toke$(OBJ_EXT): feature.h
toke$(OBJ_EXT): form.h
toke$(OBJ_EXT): gv.h
toke$(OBJ_EXT): handy.h
toke$(OBJ_EXT): hv.h
toke$(OBJ_EXT): hv_func.h
toke$(OBJ_EXT): hv_macro.h
toke$(OBJ_EXT): inline.h
toke$(OBJ_EXT): intrpvar.h
toke$(OBJ_EXT): invlist_inline.h
toke$(OBJ_EXT): iperlsys.h
toke$(OBJ_EXT): keywords.h
toke$(OBJ_EXT): locale_table.h
toke$(OBJ_EXT): mg.h
toke$(OBJ_EXT): mg_vtable.h
toke$(OBJ_EXT): mydtrace.h
toke$(OBJ_EXT): nostdio.h
toke$(OBJ_EXT): op.h
toke$(OBJ_EXT): op_reg_common.h
toke$(OBJ_EXT): opcode.h
toke$(OBJ_EXT): opnames.h
toke$(OBJ_EXT): overload.h
toke$(OBJ_EXT): pad.h
toke$(OBJ_EXT): parser.h
toke$(OBJ_EXT): patchlevel.h
toke$(OBJ_EXT): perl.h
toke$(OBJ_EXT): perl_langinfo.h
toke$(OBJ_EXT): perl_siphash.h
toke$(OBJ_EXT): perlio.h
toke$(OBJ_EXT): perlstatic.h
toke$(OBJ_EXT): perlvars.h
toke$(OBJ_EXT): perly.h
toke$(OBJ_EXT): pp.h
toke$(OBJ_EXT): pp_proto.h
toke$(OBJ_EXT): proto.h
toke$(OBJ_EXT): regcharclass.h
toke$(OBJ_EXT): regexp.h
toke$(OBJ_EXT): sbox32_hash.h
toke$(OBJ_EXT): scope.h
toke$(OBJ_EXT): scope_types.h
toke$(OBJ_EXT): sv.h
toke$(OBJ_EXT): sv_inline.h
toke$(OBJ_EXT): thread.h
toke$(OBJ_EXT): toke.c
toke$(OBJ_EXT): unicode_constants.h
toke$(OBJ_EXT): unixish.h
toke$(OBJ_EXT): utf8.h
toke$(OBJ_EXT): util.h
toke$(OBJ_EXT): warnings.h
toke$(OBJ_EXT): zaphod32_hash.h
toke$(OBJ_EXT): cflags
universal$(OBJ_EXT): CROSS_ROOT/include/alloca.h
universal$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
universal$(OBJ_EXT): CROSS_ROOT/include/assert.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
universal$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
universal$(OBJ_EXT): CROSS_ROOT/include/ctype.h
universal$(OBJ_EXT): CROSS_ROOT/include/dirent.h
universal$(OBJ_EXT): CROSS_ROOT/include/endian.h
universal$(OBJ_EXT): CROSS_ROOT/include/errno.h
universal$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
universal$(OBJ_EXT): CROSS_ROOT/include/features.h
universal$(OBJ_EXT): CROSS_ROOT/include/float.h
universal$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
universal$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
universal$(OBJ_EXT): CROSS_ROOT/include/limits.h
universal$(OBJ_EXT): CROSS_ROOT/include/locale.h
universal$(OBJ_EXT): CROSS_ROOT/include/math.h
universal$(OBJ_EXT): CROSS_ROOT/include/netdb.h
universal$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
universal$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
universal$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
universal$(OBJ_EXT): CROSS_ROOT/include/signal.h
universal$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
universal$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
universal$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
universal$(OBJ_EXT): CROSS_ROOT/include/stddef.h
universal$(OBJ_EXT): CROSS_ROOT/include/stdint.h
universal$(OBJ_EXT): CROSS_ROOT/include/stdio.h
universal$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
universal$(OBJ_EXT): CROSS_ROOT/include/string.h
universal$(OBJ_EXT): CROSS_ROOT/include/strings.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
universal$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
universal$(OBJ_EXT): CROSS_ROOT/include/time.h
universal$(OBJ_EXT): CROSS_ROOT/include/unistd.h
universal$(OBJ_EXT): CROSS_ROOT/include/wchar.h
universal$(OBJ_EXT): EXTERN.h
universal$(OBJ_EXT): XSUB.h
universal$(OBJ_EXT): av.h
universal$(OBJ_EXT): charclass_invlists.h
universal$(OBJ_EXT): config.h
universal$(OBJ_EXT): cop.h
universal$(OBJ_EXT): cv.h
universal$(OBJ_EXT): embed.h
universal$(OBJ_EXT): embedvar.h
universal$(OBJ_EXT): form.h
universal$(OBJ_EXT): gv.h
universal$(OBJ_EXT): handy.h
universal$(OBJ_EXT): hv.h
universal$(OBJ_EXT): hv_func.h
universal$(OBJ_EXT): hv_macro.h
universal$(OBJ_EXT): inline.h
universal$(OBJ_EXT): intrpvar.h
universal$(OBJ_EXT): iperlsys.h
universal$(OBJ_EXT): locale_table.h
universal$(OBJ_EXT): mg.h
universal$(OBJ_EXT): mg_vtable.h
universal$(OBJ_EXT): mydtrace.h
universal$(OBJ_EXT): nostdio.h
universal$(OBJ_EXT): op.h
universal$(OBJ_EXT): op_reg_common.h
universal$(OBJ_EXT): opcode.h
universal$(OBJ_EXT): opnames.h
universal$(OBJ_EXT): overload.h
universal$(OBJ_EXT): pad.h
universal$(OBJ_EXT): parser.h
universal$(OBJ_EXT): patchlevel.h
universal$(OBJ_EXT): perl.h
universal$(OBJ_EXT): perl_langinfo.h
universal$(OBJ_EXT): perl_siphash.h
universal$(OBJ_EXT): perlio.h
universal$(OBJ_EXT): perliol.h
universal$(OBJ_EXT): perlstatic.h
universal$(OBJ_EXT): perlvars.h
universal$(OBJ_EXT): perly.h
universal$(OBJ_EXT): pp.h
universal$(OBJ_EXT): pp_proto.h
universal$(OBJ_EXT): proto.h
universal$(OBJ_EXT): regcharclass.h
universal$(OBJ_EXT): regexp.h
universal$(OBJ_EXT): sbox32_hash.h
universal$(OBJ_EXT): scope.h
universal$(OBJ_EXT): scope_types.h
universal$(OBJ_EXT): sv.h
universal$(OBJ_EXT): sv_inline.h
universal$(OBJ_EXT): thread.h
universal$(OBJ_EXT): unicode_constants.h
universal$(OBJ_EXT): universal.c
universal$(OBJ_EXT): unixish.h
universal$(OBJ_EXT): utf8.h
universal$(OBJ_EXT): util.h
universal$(OBJ_EXT): vutil.h
universal$(OBJ_EXT): vxs.inc
universal$(OBJ_EXT): warnings.h
universal$(OBJ_EXT): zaphod32_hash.h
universal$(OBJ_EXT): cflags
utf8$(OBJ_EXT): CROSS_ROOT/include/alloca.h
utf8$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
utf8$(OBJ_EXT): CROSS_ROOT/include/assert.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
utf8$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
utf8$(OBJ_EXT): CROSS_ROOT/include/ctype.h
utf8$(OBJ_EXT): CROSS_ROOT/include/dirent.h
utf8$(OBJ_EXT): CROSS_ROOT/include/endian.h
utf8$(OBJ_EXT): CROSS_ROOT/include/errno.h
utf8$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
utf8$(OBJ_EXT): CROSS_ROOT/include/features.h
utf8$(OBJ_EXT): CROSS_ROOT/include/float.h
utf8$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
utf8$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
utf8$(OBJ_EXT): CROSS_ROOT/include/limits.h
utf8$(OBJ_EXT): CROSS_ROOT/include/locale.h
utf8$(OBJ_EXT): CROSS_ROOT/include/math.h
utf8$(OBJ_EXT): CROSS_ROOT/include/netdb.h
utf8$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
utf8$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
utf8$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
utf8$(OBJ_EXT): CROSS_ROOT/include/signal.h
utf8$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
utf8$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
utf8$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
utf8$(OBJ_EXT): CROSS_ROOT/include/stddef.h
utf8$(OBJ_EXT): CROSS_ROOT/include/stdint.h
utf8$(OBJ_EXT): CROSS_ROOT/include/stdio.h
utf8$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
utf8$(OBJ_EXT): CROSS_ROOT/include/string.h
utf8$(OBJ_EXT): CROSS_ROOT/include/strings.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
utf8$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
utf8$(OBJ_EXT): CROSS_ROOT/include/time.h
utf8$(OBJ_EXT): CROSS_ROOT/include/unistd.h
utf8$(OBJ_EXT): CROSS_ROOT/include/wchar.h
utf8$(OBJ_EXT): EXTERN.h
utf8$(OBJ_EXT): av.h
utf8$(OBJ_EXT): charclass_invlists.h
utf8$(OBJ_EXT): config.h
utf8$(OBJ_EXT): cop.h
utf8$(OBJ_EXT): cv.h
utf8$(OBJ_EXT): embed.h
utf8$(OBJ_EXT): embedvar.h
utf8$(OBJ_EXT): form.h
utf8$(OBJ_EXT): gv.h
utf8$(OBJ_EXT): handy.h
utf8$(OBJ_EXT): hv.h
utf8$(OBJ_EXT): hv_func.h
utf8$(OBJ_EXT): hv_macro.h
utf8$(OBJ_EXT): inline.h
utf8$(OBJ_EXT): intrpvar.h
utf8$(OBJ_EXT): invlist_inline.h
utf8$(OBJ_EXT): iperlsys.h
utf8$(OBJ_EXT): locale_table.h
utf8$(OBJ_EXT): mg.h
utf8$(OBJ_EXT): mg_vtable.h
utf8$(OBJ_EXT): mydtrace.h
utf8$(OBJ_EXT): nostdio.h
utf8$(OBJ_EXT): op.h
utf8$(OBJ_EXT): op_reg_common.h
utf8$(OBJ_EXT): opcode.h
utf8$(OBJ_EXT): opnames.h
utf8$(OBJ_EXT): overload.h
utf8$(OBJ_EXT): pad.h
utf8$(OBJ_EXT): parser.h
utf8$(OBJ_EXT): patchlevel.h
utf8$(OBJ_EXT): perl.h
utf8$(OBJ_EXT): perl_langinfo.h
utf8$(OBJ_EXT): perl_siphash.h
utf8$(OBJ_EXT): perlio.h
utf8$(OBJ_EXT): perlstatic.h
utf8$(OBJ_EXT): perlvars.h
utf8$(OBJ_EXT): perly.h
utf8$(OBJ_EXT): pp.h
utf8$(OBJ_EXT): pp_proto.h
utf8$(OBJ_EXT): proto.h
utf8$(OBJ_EXT): regcharclass.h
utf8$(OBJ_EXT): regexp.h
utf8$(OBJ_EXT): sbox32_hash.h
utf8$(OBJ_EXT): scope.h
utf8$(OBJ_EXT): scope_types.h
utf8$(OBJ_EXT): sv.h
utf8$(OBJ_EXT): sv_inline.h
utf8$(OBJ_EXT): thread.h
utf8$(OBJ_EXT): unicode_constants.h
utf8$(OBJ_EXT): unixish.h
utf8$(OBJ_EXT): utf8.c
utf8$(OBJ_EXT): utf8.h
utf8$(OBJ_EXT): util.h
utf8$(OBJ_EXT): warnings.h
utf8$(OBJ_EXT): zaphod32_hash.h
utf8$(OBJ_EXT): cflags
util$(OBJ_EXT): CROSS_ROOT/include/alloca.h
util$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
util$(OBJ_EXT): CROSS_ROOT/include/assert.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
util$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
util$(OBJ_EXT): CROSS_ROOT/include/ctype.h
util$(OBJ_EXT): CROSS_ROOT/include/dirent.h
util$(OBJ_EXT): CROSS_ROOT/include/endian.h
util$(OBJ_EXT): CROSS_ROOT/include/errno.h
util$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
util$(OBJ_EXT): CROSS_ROOT/include/features.h
util$(OBJ_EXT): CROSS_ROOT/include/float.h
util$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
util$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
util$(OBJ_EXT): CROSS_ROOT/include/limits.h
util$(OBJ_EXT): CROSS_ROOT/include/locale.h
util$(OBJ_EXT): CROSS_ROOT/include/math.h
util$(OBJ_EXT): CROSS_ROOT/include/netdb.h
util$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
util$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
util$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
util$(OBJ_EXT): CROSS_ROOT/include/signal.h
util$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
util$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
util$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
util$(OBJ_EXT): CROSS_ROOT/include/stddef.h
util$(OBJ_EXT): CROSS_ROOT/include/stdint.h
util$(OBJ_EXT): CROSS_ROOT/include/stdio.h
util$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
util$(OBJ_EXT): CROSS_ROOT/include/string.h
util$(OBJ_EXT): CROSS_ROOT/include/strings.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
util$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
util$(OBJ_EXT): CROSS_ROOT/include/time.h
util$(OBJ_EXT): CROSS_ROOT/include/unistd.h
util$(OBJ_EXT): CROSS_ROOT/include/wchar.h
util$(OBJ_EXT): EXTERN.h
util$(OBJ_EXT): av.h
util$(OBJ_EXT): charclass_invlists.h
util$(OBJ_EXT): config.h
util$(OBJ_EXT): cop.h
util$(OBJ_EXT): cv.h
util$(OBJ_EXT): embed.h
util$(OBJ_EXT): embedvar.h
util$(OBJ_EXT): form.h
util$(OBJ_EXT): gv.h
util$(OBJ_EXT): handy.h
util$(OBJ_EXT): hv.h
util$(OBJ_EXT): hv_func.h
util$(OBJ_EXT): hv_macro.h
util$(OBJ_EXT): inline.h
util$(OBJ_EXT): intrpvar.h
util$(OBJ_EXT): iperlsys.h
util$(OBJ_EXT): locale_table.h
util$(OBJ_EXT): mg.h
util$(OBJ_EXT): mg_vtable.h
util$(OBJ_EXT): mydtrace.h
util$(OBJ_EXT): nostdio.h
util$(OBJ_EXT): op.h
util$(OBJ_EXT): op_reg_common.h
util$(OBJ_EXT): opcode.h
util$(OBJ_EXT): opnames.h
util$(OBJ_EXT): overload.h
util$(OBJ_EXT): pad.h
util$(OBJ_EXT): parser.h
util$(OBJ_EXT): patchlevel.h
util$(OBJ_EXT): perl.h
util$(OBJ_EXT): perl_langinfo.h
util$(OBJ_EXT): perl_siphash.h
util$(OBJ_EXT): perlio.h
util$(OBJ_EXT): perliol.h
util$(OBJ_EXT): perlstatic.h
util$(OBJ_EXT): perlvars.h
util$(OBJ_EXT): perly.h
util$(OBJ_EXT): pp.h
util$(OBJ_EXT): pp_proto.h
util$(OBJ_EXT): proto.h
util$(OBJ_EXT): reentr.h
util$(OBJ_EXT): regcharclass.h
util$(OBJ_EXT): regexp.h
util$(OBJ_EXT): sbox32_hash.h
util$(OBJ_EXT): scope.h
util$(OBJ_EXT): scope_types.h
util$(OBJ_EXT): sv.h
util$(OBJ_EXT): sv_inline.h
util$(OBJ_EXT): thread.h
util$(OBJ_EXT): unicode_constants.h
util$(OBJ_EXT): unixish.h
util$(OBJ_EXT): utf8.h
util$(OBJ_EXT): util.c
util$(OBJ_EXT): util.h
util$(OBJ_EXT): vutil.c
util$(OBJ_EXT): vutil.h
util$(OBJ_EXT): warnings.h
util$(OBJ_EXT): zaphod32_hash.h
util$(OBJ_EXT): cflags
perlmain$(OBJ_EXT): CROSS_ROOT/include/alloca.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/alloca.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/assert.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/assert.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/ctype.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/ctype.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/dirent.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/dirent.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/endian.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/endian.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/errno.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/errno.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/features.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/features.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/float.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/float.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/limits.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/limits.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/locale.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/locale.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/math.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/math.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/netdb.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/netdb.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/signal.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/signal.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/stddef.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/stddef.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/stdint.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/stdint.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/stdio.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/stdio.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/string.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/string.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/strings.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/strings.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/time.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/time.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/unistd.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/unistd.h
perlmain$(OBJ_EXT): CROSS_ROOT/include/wchar.h
miniperlmain$(OBJ_EXT): CROSS_ROOT/include/wchar.h
perlmain$(OBJ_EXT): EXTERN.h
miniperlmain$(OBJ_EXT): EXTERN.h
perlmain$(OBJ_EXT): XSUB.h
miniperlmain$(OBJ_EXT): XSUB.h
perlmain$(OBJ_EXT): av.h
miniperlmain$(OBJ_EXT): av.h
perlmain$(OBJ_EXT): charclass_invlists.h
miniperlmain$(OBJ_EXT): charclass_invlists.h
perlmain$(OBJ_EXT): config.h
miniperlmain$(OBJ_EXT): config.h
perlmain$(OBJ_EXT): cop.h
miniperlmain$(OBJ_EXT): cop.h
perlmain$(OBJ_EXT): cv.h
miniperlmain$(OBJ_EXT): cv.h
perlmain$(OBJ_EXT): embed.h
miniperlmain$(OBJ_EXT): embed.h
perlmain$(OBJ_EXT): embedvar.h
miniperlmain$(OBJ_EXT): embedvar.h
perlmain$(OBJ_EXT): form.h
miniperlmain$(OBJ_EXT): form.h
perlmain$(OBJ_EXT): gv.h
miniperlmain$(OBJ_EXT): gv.h
perlmain$(OBJ_EXT): handy.h
miniperlmain$(OBJ_EXT): handy.h
perlmain$(OBJ_EXT): hv.h
miniperlmain$(OBJ_EXT): hv.h
perlmain$(OBJ_EXT): hv_func.h
miniperlmain$(OBJ_EXT): hv_func.h
perlmain$(OBJ_EXT): hv_macro.h
miniperlmain$(OBJ_EXT): hv_macro.h
perlmain$(OBJ_EXT): inline.h
miniperlmain$(OBJ_EXT): inline.h
perlmain$(OBJ_EXT): intrpvar.h
miniperlmain$(OBJ_EXT): intrpvar.h
perlmain$(OBJ_EXT): iperlsys.h
miniperlmain$(OBJ_EXT): iperlsys.h
perlmain$(OBJ_EXT): locale_table.h
miniperlmain$(OBJ_EXT): locale_table.h
perlmain$(OBJ_EXT): mg.h
miniperlmain$(OBJ_EXT): mg.h
perlmain$(OBJ_EXT): mg_vtable.h
miniperlmain$(OBJ_EXT): mg_vtable.h
perlmain$(OBJ_EXT): miniperlmain.c
miniperlmain$(OBJ_EXT): miniperlmain.c
perlmain$(OBJ_EXT): mydtrace.h
miniperlmain$(OBJ_EXT): mydtrace.h
perlmain$(OBJ_EXT): nostdio.h
miniperlmain$(OBJ_EXT): nostdio.h
perlmain$(OBJ_EXT): op.h
miniperlmain$(OBJ_EXT): op.h
perlmain$(OBJ_EXT): op_reg_common.h
miniperlmain$(OBJ_EXT): op_reg_common.h
perlmain$(OBJ_EXT): opcode.h
miniperlmain$(OBJ_EXT): opcode.h
perlmain$(OBJ_EXT): opnames.h
miniperlmain$(OBJ_EXT): opnames.h
perlmain$(OBJ_EXT): overload.h
miniperlmain$(OBJ_EXT): overload.h
perlmain$(OBJ_EXT): pad.h
miniperlmain$(OBJ_EXT): pad.h
perlmain$(OBJ_EXT): parser.h
miniperlmain$(OBJ_EXT): parser.h
perlmain$(OBJ_EXT): patchlevel.h
miniperlmain$(OBJ_EXT): patchlevel.h
perlmain$(OBJ_EXT): perl.h
miniperlmain$(OBJ_EXT): perl.h
perlmain$(OBJ_EXT): perl_langinfo.h
miniperlmain$(OBJ_EXT): perl_langinfo.h
perlmain$(OBJ_EXT): perl_siphash.h
miniperlmain$(OBJ_EXT): perl_siphash.h
perlmain$(OBJ_EXT): perlio.h
miniperlmain$(OBJ_EXT): perlio.h
perlmain$(OBJ_EXT): perlstatic.h
miniperlmain$(OBJ_EXT): perlstatic.h
perlmain$(OBJ_EXT): perlvars.h
miniperlmain$(OBJ_EXT): perlvars.h
perlmain$(OBJ_EXT): perly.h
miniperlmain$(OBJ_EXT): perly.h
perlmain$(OBJ_EXT): pp.h
miniperlmain$(OBJ_EXT): pp.h
perlmain$(OBJ_EXT): pp_proto.h
miniperlmain$(OBJ_EXT): pp_proto.h
perlmain$(OBJ_EXT): proto.h
miniperlmain$(OBJ_EXT): proto.h
perlmain$(OBJ_EXT): regcharclass.h
miniperlmain$(OBJ_EXT): regcharclass.h
perlmain$(OBJ_EXT): regexp.h
miniperlmain$(OBJ_EXT): regexp.h
perlmain$(OBJ_EXT): sbox32_hash.h
miniperlmain$(OBJ_EXT): sbox32_hash.h
perlmain$(OBJ_EXT): scope.h
miniperlmain$(OBJ_EXT): scope.h
perlmain$(OBJ_EXT): scope_types.h
miniperlmain$(OBJ_EXT): scope_types.h
perlmain$(OBJ_EXT): sv.h
miniperlmain$(OBJ_EXT): sv.h
perlmain$(OBJ_EXT): sv_inline.h
miniperlmain$(OBJ_EXT): sv_inline.h
perlmain$(OBJ_EXT): thread.h
miniperlmain$(OBJ_EXT): thread.h
perlmain$(OBJ_EXT): unicode_constants.h
miniperlmain$(OBJ_EXT): unicode_constants.h
perlmain$(OBJ_EXT): unixish.h
miniperlmain$(OBJ_EXT): unixish.h
perlmain$(OBJ_EXT): utf8.h
miniperlmain$(OBJ_EXT): utf8.h
perlmain$(OBJ_EXT): util.h
miniperlmain$(OBJ_EXT): util.h
perlmain$(OBJ_EXT): warnings.h
miniperlmain$(OBJ_EXT): warnings.h
perlmain$(OBJ_EXT): zaphod32_hash.h
miniperlmain$(OBJ_EXT): zaphod32_hash.h
perlmain$(OBJ_EXT): cflags
miniperlmain$(OBJ_EXT): cflags
opmini$(OBJ_EXT): CROSS_ROOT/include/alloca.h
opmini$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
opmini$(OBJ_EXT): CROSS_ROOT/include/assert.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
opmini$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
opmini$(OBJ_EXT): CROSS_ROOT/include/ctype.h
opmini$(OBJ_EXT): CROSS_ROOT/include/dirent.h
opmini$(OBJ_EXT): CROSS_ROOT/include/endian.h
opmini$(OBJ_EXT): CROSS_ROOT/include/errno.h
opmini$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
opmini$(OBJ_EXT): CROSS_ROOT/include/features.h
opmini$(OBJ_EXT): CROSS_ROOT/include/float.h
opmini$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
opmini$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
opmini$(OBJ_EXT): CROSS_ROOT/include/limits.h
opmini$(OBJ_EXT): CROSS_ROOT/include/locale.h
opmini$(OBJ_EXT): CROSS_ROOT/include/math.h
opmini$(OBJ_EXT): CROSS_ROOT/include/netdb.h
opmini$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
opmini$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
opmini$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
opmini$(OBJ_EXT): CROSS_ROOT/include/signal.h
opmini$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
opmini$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
opmini$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
opmini$(OBJ_EXT): CROSS_ROOT/include/stddef.h
opmini$(OBJ_EXT): CROSS_ROOT/include/stdint.h
opmini$(OBJ_EXT): CROSS_ROOT/include/stdio.h
opmini$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
opmini$(OBJ_EXT): CROSS_ROOT/include/string.h
opmini$(OBJ_EXT): CROSS_ROOT/include/strings.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
opmini$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
opmini$(OBJ_EXT): CROSS_ROOT/include/time.h
opmini$(OBJ_EXT): CROSS_ROOT/include/unistd.h
opmini$(OBJ_EXT): CROSS_ROOT/include/wchar.h
opmini$(OBJ_EXT): EXTERN.h
opmini$(OBJ_EXT): XSUB.h
opmini$(OBJ_EXT): av.h
opmini$(OBJ_EXT): charclass_invlists.h
opmini$(OBJ_EXT): config.h
opmini$(OBJ_EXT): cop.h
opmini$(OBJ_EXT): cv.h
opmini$(OBJ_EXT): embed.h
opmini$(OBJ_EXT): embedvar.h
opmini$(OBJ_EXT): feature.h
opmini$(OBJ_EXT): form.h
opmini$(OBJ_EXT): gv.h
opmini$(OBJ_EXT): handy.h
opmini$(OBJ_EXT): hv.h
opmini$(OBJ_EXT): hv_func.h
opmini$(OBJ_EXT): hv_macro.h
opmini$(OBJ_EXT): inline.h
opmini$(OBJ_EXT): intrpvar.h
opmini$(OBJ_EXT): invlist_inline.h
opmini$(OBJ_EXT): iperlsys.h
opmini$(OBJ_EXT): keywords.h
opmini$(OBJ_EXT): locale_table.h
opmini$(OBJ_EXT): mg.h
opmini$(OBJ_EXT): mg_vtable.h
opmini$(OBJ_EXT): mydtrace.h
opmini$(OBJ_EXT): nostdio.h
opmini$(OBJ_EXT): op.h
opmini$(OBJ_EXT): op_reg_common.h
opmini$(OBJ_EXT): opcode.h
opmini$(OBJ_EXT): opmini.c
opmini$(OBJ_EXT): opnames.h
opmini$(OBJ_EXT): overload.h
opmini$(OBJ_EXT): pad.h
opmini$(OBJ_EXT): parser.h
opmini$(OBJ_EXT): patchlevel.h
opmini$(OBJ_EXT): perl.h
opmini$(OBJ_EXT): perl_langinfo.h
opmini$(OBJ_EXT): perl_siphash.h
opmini$(OBJ_EXT): perlio.h
opmini$(OBJ_EXT): perlstatic.h
opmini$(OBJ_EXT): perlvars.h
opmini$(OBJ_EXT): perly.h
opmini$(OBJ_EXT): pp.h
opmini$(OBJ_EXT): pp_proto.h
opmini$(OBJ_EXT): proto.h
opmini$(OBJ_EXT): regcharclass.h
opmini$(OBJ_EXT): regcomp.h
opmini$(OBJ_EXT): regexp.h
opmini$(OBJ_EXT): regnodes.h
opmini$(OBJ_EXT): sbox32_hash.h
opmini$(OBJ_EXT): scope.h
opmini$(OBJ_EXT): scope_types.h
opmini$(OBJ_EXT): sv.h
opmini$(OBJ_EXT): sv_inline.h
opmini$(OBJ_EXT): thread.h
opmini$(OBJ_EXT): unicode_constants.h
opmini$(OBJ_EXT): unixish.h
opmini$(OBJ_EXT): utf8.h
opmini$(OBJ_EXT): util.h
opmini$(OBJ_EXT): warnings.h
opmini$(OBJ_EXT): zaphod32_hash.h
opmini$(OBJ_EXT): cflags
perlmini$(OBJ_EXT): CROSS_ROOT/include/alloca.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/assert.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/ctype.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/dirent.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/endian.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/errno.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/features.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/float.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/limits.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/locale.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/math.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/netdb.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/signal.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/stddef.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/stdint.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/stdio.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/string.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/strings.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/time.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/unistd.h
perlmini$(OBJ_EXT): CROSS_ROOT/include/wchar.h
perlmini$(OBJ_EXT): EXTERN.h
perlmini$(OBJ_EXT): av.h
perlmini$(OBJ_EXT): charclass_invlists.h
perlmini$(OBJ_EXT): config.h
perlmini$(OBJ_EXT): cop.h
perlmini$(OBJ_EXT): cv.h
perlmini$(OBJ_EXT): embed.h
perlmini$(OBJ_EXT): embedvar.h
perlmini$(OBJ_EXT): form.h
perlmini$(OBJ_EXT): gv.h
perlmini$(OBJ_EXT): handy.h
perlmini$(OBJ_EXT): hv.h
perlmini$(OBJ_EXT): hv_func.h
perlmini$(OBJ_EXT): hv_macro.h
perlmini$(OBJ_EXT): inline.h
perlmini$(OBJ_EXT): intrpvar.h
perlmini$(OBJ_EXT): iperlsys.h
perlmini$(OBJ_EXT): locale_table.h
perlmini$(OBJ_EXT): mg.h
perlmini$(OBJ_EXT): mg_vtable.h
perlmini$(OBJ_EXT): mydtrace.h
perlmini$(OBJ_EXT): nostdio.h
perlmini$(OBJ_EXT): op.h
perlmini$(OBJ_EXT): op_reg_common.h
perlmini$(OBJ_EXT): opcode.h
perlmini$(OBJ_EXT): opnames.h
perlmini$(OBJ_EXT): overload.h
perlmini$(OBJ_EXT): pad.h
perlmini$(OBJ_EXT): parser.h
perlmini$(OBJ_EXT): patchlevel.h
perlmini$(OBJ_EXT): perl.h
perlmini$(OBJ_EXT): perl_langinfo.h
perlmini$(OBJ_EXT): perl_siphash.h
perlmini$(OBJ_EXT): perlio.h
perlmini$(OBJ_EXT): perlmini.c
perlmini$(OBJ_EXT): perlstatic.h
perlmini$(OBJ_EXT): perlvars.h
perlmini$(OBJ_EXT): perly.h
perlmini$(OBJ_EXT): pp.h
perlmini$(OBJ_EXT): pp_proto.h
perlmini$(OBJ_EXT): proto.h
perlmini$(OBJ_EXT): regcharclass.h
perlmini$(OBJ_EXT): regexp.h
perlmini$(OBJ_EXT): sbox32_hash.h
perlmini$(OBJ_EXT): scope.h
perlmini$(OBJ_EXT): scope_types.h
perlmini$(OBJ_EXT): sv.h
perlmini$(OBJ_EXT): sv_inline.h
perlmini$(OBJ_EXT): thread.h
perlmini$(OBJ_EXT): unicode_constants.h
perlmini$(OBJ_EXT): unixish.h
perlmini$(OBJ_EXT): utf8.h
perlmini$(OBJ_EXT): util.h
perlmini$(OBJ_EXT): warnings.h
perlmini$(OBJ_EXT): zaphod32_hash.h
perlmini$(OBJ_EXT): cflags
universalmini$(OBJ_EXT): CROSS_ROOT/include/alloca.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/arpa/inet.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/assert.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/alltypes.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/dirent.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/errno.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/fcntl.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/float.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/ioctl_fix.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/ipc.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/ipcstat.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/limits.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/posix.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/resource.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/sem.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/setjmp.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/signal.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/socket.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/stat.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/bits/stdint.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/ctype.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/dirent.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/endian.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/errno.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/fcntl.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/features.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/float.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/inttypes.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/langinfo.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/limits.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/locale.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/math.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/netdb.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/netinet/in.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/nl_types.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/setjmp.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/signal.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/stdarg.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/stdbool.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/stdc-predef.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/stddef.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/stdint.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/stdio.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/stdlib.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/string.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/strings.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/ioctl.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/ipc.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/param.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/resource.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/select.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/sem.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/socket.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/stat.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/time.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/times.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/types.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/sys/wait.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/time.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/unistd.h
universalmini$(OBJ_EXT): CROSS_ROOT/include/wchar.h
universalmini$(OBJ_EXT): EXTERN.h
universalmini$(OBJ_EXT): XSUB.h
universalmini$(OBJ_EXT): av.h
universalmini$(OBJ_EXT): charclass_invlists.h
universalmini$(OBJ_EXT): config.h
universalmini$(OBJ_EXT): cop.h
universalmini$(OBJ_EXT): cv.h
universalmini$(OBJ_EXT): embed.h
universalmini$(OBJ_EXT): embedvar.h
universalmini$(OBJ_EXT): form.h
universalmini$(OBJ_EXT): gv.h
universalmini$(OBJ_EXT): handy.h
universalmini$(OBJ_EXT): hv.h
universalmini$(OBJ_EXT): hv_func.h
universalmini$(OBJ_EXT): hv_macro.h
universalmini$(OBJ_EXT): inline.h
universalmini$(OBJ_EXT): intrpvar.h
universalmini$(OBJ_EXT): iperlsys.h
universalmini$(OBJ_EXT): locale_table.h
universalmini$(OBJ_EXT): mg.h
universalmini$(OBJ_EXT): mg_vtable.h
universalmini$(OBJ_EXT): mydtrace.h
universalmini$(OBJ_EXT): nostdio.h
universalmini$(OBJ_EXT): op.h
universalmini$(OBJ_EXT): op_reg_common.h
universalmini$(OBJ_EXT): opcode.h
universalmini$(OBJ_EXT): opnames.h
universalmini$(OBJ_EXT): overload.h
universalmini$(OBJ_EXT): pad.h
universalmini$(OBJ_EXT): parser.h
universalmini$(OBJ_EXT): patchlevel.h
universalmini$(OBJ_EXT): perl.h
universalmini$(OBJ_EXT): perl_langinfo.h
universalmini$(OBJ_EXT): perl_siphash.h
universalmini$(OBJ_EXT): perlio.h
universalmini$(OBJ_EXT): perliol.h
universalmini$(OBJ_EXT): perlstatic.h
universalmini$(OBJ_EXT): perlvars.h
universalmini$(OBJ_EXT): perly.h
universalmini$(OBJ_EXT): pp.h
universalmini$(OBJ_EXT): pp_proto.h
universalmini$(OBJ_EXT): proto.h
universalmini$(OBJ_EXT): regcharclass.h
universalmini$(OBJ_EXT): regexp.h
universalmini$(OBJ_EXT): sbox32_hash.h
universalmini$(OBJ_EXT): scope.h
universalmini$(OBJ_EXT): scope_types.h
universalmini$(OBJ_EXT): sv.h
universalmini$(OBJ_EXT): sv_inline.h
universalmini$(OBJ_EXT): thread.h
universalmini$(OBJ_EXT): unicode_constants.h
universalmini$(OBJ_EXT): universalmini.c
universalmini$(OBJ_EXT): unixish.h
universalmini$(OBJ_EXT): utf8.h
universalmini$(OBJ_EXT): util.h
universalmini$(OBJ_EXT): vutil.h
universalmini$(OBJ_EXT): vxs.inc
universalmini$(OBJ_EXT): warnings.h
universalmini$(OBJ_EXT): zaphod32_hash.h
universalmini$(OBJ_EXT): cflags
# WARNING: Put nothing here or make depend will gobble it up!
