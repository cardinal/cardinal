DEBUG = false
CONFIG = {} 
$tests = 0
$test_files = 0
$ok = 0
$nok = 0
$unknown = 0
$failures = 0
$expected_failures = 0
$unexpected_failures = []
$unexpected_passes = 0
$u_p_files = []
$missing = 0
$missing_files = []
$toomany = 0
$toomany_files = []
$issue_counts = Hash.new(0)
$issue_lacks = 0
$i_l_files = []
$pl = false
$start = Time.now

def clean?
    return false if $nok > $expected_failures
    return false if $failures > 0
    return false if $unknown > 0
    return false if $missing > 0
    return false if $toomany > 0
    return false if $issue_lacks > 0
    return true 
end

def pl(word)
    $pl ? word + "s" : word
end

def were
    $pl ? "were" : "was"
end

def are
    $pl ? "are" : "is"
end

def them
    $pl ? "them" : "it"
end

def parrot(input, output, grammar="", target="")
    target = "--target=#{target}" if target != ""
    sh "#{CONFIG[:parrot]} #{grammar} #{target} -o #{output} #{input}"
end

def make_exe(pbc)
    sh "#{CONFIG[:pbc_to_exe]} cardinal.pbc"
end

def test(file, name="")
    print "Adding #{file} as a test " if DEBUG
    if name == ""
        name = file.gsub(/.t$/,'').gsub(/^[0-9]+-/,'').gsub(/-/,'').gsub(/.*\//,'')
    end
    puts "named #{name}" if DEBUG
    task name => ["cardinal", "Test.pir"] do
        run_test file
    end
end

def run_test(file)
    puts file if DEBUG
    $test_files += 1
    IO.popen("./cardinal t/#{file}", "r") do |t|
        begin 
            plan = t.readline
        rescue EOFError
            plan = "x"
        end
        puts plan if DEBUG
        if plan =~ /^1\.\.([0-9]+)/
            tests = $1.to_i
            $tests += tests
            result = "#{$1} tests... "
            ok = 0
            nok = 0
            unknown = 0
            test = 0
            t.readlines.each do |line|
                test += 1
                puts line if DEBUG
                if line =~ /^ok #{test}/
                    ok += 1
                    if line =~ /TODO/
                        $unexpected_passes += 1
                        $u_p_files += [file]
                    end
                else 
                    if line =~ /^not ok #{test}/
                        nok += 1
                        if line =~ /(TODO|SKIP)/
                            $expected_failures += 1
                            if line =~ /See issue #([0-9]+)/
                                $issue_counts[$1] += 1
                            else
                                puts "Lacks issue." if DEBUG
                                $issue_lacks += 1
                                $i_l_files += [file]
                            end
                        else
                            $unexpected_failures += [file]
                        end
                    else
                        unknown += 1
                    end
                end
            end
            result += "#{ok} ok "
            $ok += ok
            result += "#{nok} not ok"
            $nok += nok
            result += " #{unknown} unknown" if unknown > 0
            $unknown += unknown
            if test < tests 
                result += " MISSING TESTS"
                $missing += 1
                $missing_files += [file]
            end
            if test > tests
                result += " TOO MANY TESTS"
                $toomany += 1
                $toomany_files += [file]
            end
        else
            result = "Complete failure... no plan given"
            $failures += 1
        end
        puts "Running test #{file} #{result}"
    end
end

task :config => "build.yaml" do
    require 'yaml'
    File.open("build.yaml","r") do |f|
        CONFIG.update(YAML.load(f))
    end
    return false unless File.exist?(CONFIG[:parrot])
    return false unless File.exist?(CONFIG[:perl6grammar])
    return false unless File.exist?(CONFIG[:nqp])
    return false unless File.exist?(CONFIG[:pct])
    return false unless File.exist?(CONFIG[:pbc_to_exe])
end

file "build.yaml" do 
    require 'yaml'
    config = {}
    IO.popen("parrot_config build_dir", "r") do |p|
        config[:build_dir] = p.readline.chomp
    end
    puts "Detected parrot_config reports that build_dir is #{config[:build_dir]}."

    config[:parrot] = config[:build_dir] + "/parrot"
    config[:perl6grammar] = config[:build_dir] + "/runtime/parrot/library/PGE/Perl6Grammar.pbc"
    config[:nqp] = config[:build_dir] + "/compilers/nqp/nqp.pbc"
    config[:pct] = config[:build_dir] + "/runtime/parrot/library/PCT.pbc"
    config[:pbc_to_exe] = config[:build_dir] + "/pbc_to_exe"
    File.open("build.yaml","w") do |f|
        YAML.dump(config, f) 
    end
end

file "cardinal" => [:config, "cardinal.pbc"] do
    make_exe("cardinal.pbc")
end

sources = FileList.new('cardinal.pir',
                    'src/parser/quote_expression.pir',
                    'src/gen_grammar.pir',
                    'src/gen_actions.pir',
                    'src/gen_builtins.pir')

file "cardinal.pbc" => sources do
    parrot("cardinal.pir","cardinal.pbc")
end

file "src/gen_grammar.pir" => [:config, 'src/parser/grammar.pg'] do 
    parrot("src/parser/grammar.pg", "src/gen_grammar.pir", CONFIG[:perl6grammar])
end

file "src/gen_actions.pir" => [:config, "src/parser/actions.pm"] do
    parrot("src/parser/actions.pm","src/gen_actions.pir",CONFIG[:nqp],'pir')
end

builtins = FileList.new("src/builtins/guts.pir", "src/builtins/control.pir", "src/builtins/say.pir", "src/builtins/cmp.pir", "src/builtins/op.pir", "src/classes/Object.pir", "src/classes/Exception.pir", "src/classes/NilClass.pir", "src/classes/String.pir", "src/classes/Integer.pir", "src/classes/Array.pir", "src/classes/Hash.pir", "src/classes/Range.pir", "src/classes/Bool.pir", "src/classes/Kernel.pir", "src/classes/Time.pir", "src/classes/Math.pir", "src/classes/GC.pir", "src/classes/IO.pir", "src/classes/Proc.pir", "src/classes/File.pir", "src/classes/FileStat.pir", "src/classes/Dir.pir", "src/builtins/globals.pir", "src/builtins/eval.pir", "src/classes/Continuation.pir") 

file "src/gen_builtins.pir" => builtins do
    puts "Generating src/gen_builtins.pir"
    File.open('src/gen_builtins.pir','w') do |f|
        builtins.each do |b|
            f.write(".include \"#{b}\"\n")
        end
    end  
end

file "Test.pir" => ["cardinal.pbc", "Test.rb"] do
    parrot("Test.rb", "Test.pir", "cardinal.pbc", "pir")
end

task :default => ["cardinal", "Test.pir"]

namespace :test do |ns|
    test "00-sanity.t"
    test "01-stmts.t"
    test "02-functions.t"
    test "03-return.t"
    test "04-indexed.t"
    test "05-op-cmp.t"
    test "07-loops.t"
    test "08-class.t"
    test "09-test.t"
    test "10-regex.t"
    test "11-slurpy.t"
    test "12-gather.t"
    test "99-other.t"
    test "alias.t"
    test "assignment.t"
    test "blocks.t"
    test "constants.t"
    test "continuation.t"
    test "freeze.t"
    test "gc.t"
    test "nil.t"
    test "proc.t"
    test "range.t"
    test "splat.t"
    test "time.t"
    test "yield.t"
    test "zip.t"
    
    namespace :array do 
        test "array/array.t"
        test "array/at.t"
        test "array/clear.t"
        test "array/collect.t"
        test "array/compact.t"
        test "array/concat.t"
        test "array/delete.t"
        test "array/empty.t"
        test "array/equals.t"
        test "array/fetch.t"
        test "array/fill.t"
        test "array/first.t"
        test "array/flatten.t"
        test "array/grep.t"
        test "array/include.t"
        test "array/index.t"
        test "array/intersection.t"
        test "array/join.t"
        test "array/mathop.t"
        test "array/pop.t"
        test "array/reject.t"
        test "array/reverse.t"
        test "array/shift.t"
        test "array/slice.t"
        test "array/sort.t"
        test "array/to_s.t"
        test "array/uniq.t"
        test "array/values_at.t"
        test "array/warray.t"

        task :all => [:array, :at, :clear, :collect, :compact, :concat, :delete, :empty, :equals, :fetch, :fill, :first, :flatten, :grep, :include, :index, :intersection, :join, :mathop, :pop, :reject, :reverse, :shift, :slice, :sort, :to_s, :uniq, :values_at, :warray]
    end
    
    namespace :file do 
        test "file/dir.t"
        test "file/file.t"
        test "file/stat.t" 
        
        task :all => [:dir, :file, :stat]
    end

    namespace :hash do
        test "hash/hash.t"
        test "hash/exists.t"
        
        task :all => [:hash, :exists]
    end
    
    namespace :integer do
        test "integer/integer.t"
        test "integer/times.t"
        test "integer/cmp.t"

        task :all => [:integer, :times, :cmp]
    end

    namespace :kernel do
        test "kernel/exit.t"
        test "kernel/open.t"
        test "kernel/sprintf.t"

        task :all => [:exit, :open, :sprintf]
    end

    namespace :math do
        test "math/functions.t"
        
        task :all => [:functions]
    end
    
    namespace :range do
        test "range/each.t"
        test "range/infix-exclusive.t"
        test "range/infix-inclusive.t"
        test "range/membership-variants.t"
        test "range/new.t"
        test "range/to_a.t"
        test "range/to_s.t"
        test "range/tofrom-variants.t"

        task :all => [:each, :infixexclusive, :infixinclusive, :membershipvariants, :new, :to_a, :to_s, :tofromvariants]
    end 

    namespace :string do
        test "string/add.t"
        test "string/block.t"
        test "string/capitalize.t"
        test "string/chops.t"
        test "string/cmp.t"
        test "string/concat.t"
        test "string/downcase.t"
        test "string/eq.t"
        test "string/mult.t"
        test "string/new.t"
        test "string/quote.t"
        test "string/random_access.t"
        test "string/reverse.t"
        test "string/upcase.t"

        task :all => [:add, :block, :capitalize, :chops, :cmp, :concat, :downcase, :eq, :mult, :new, :quote, :random_access, :reverse, :upcase]
    end

    task :basic => [:sanity, :stmts, :functions, :return, :indexed, :opcmp, :loops, :class, :test, :regex, :slurpy, :gather, :other, :alias, :assignment, :blocks, :constants, :continuation, :freeze, :gc, :nil, :proc, :range, :splat, :time, :yield, :zip]
    task :all => [:basic, "array:all", "file:all", "hash:all", "integer:all", "kernel:all", "math:all", "range:all", "string:all"] do
        dur_seconds = Time.now.to_i - $start.to_i
        dur_minutes = 0
        while dur_seconds > 60
            dur_seconds -= 60
            dur_minutes += 1
        end
        puts "Test statistics:"
        puts " The test suite took #{dur_minutes}:#{dur_seconds}."
        puts " #{$tests} tests were run, from #{$test_files} files."
        puts " #{$ok} tests passed, #{$unexpected_passes} of which were unexpected." 
        unless $u_p_files.empty?
            $u_p_files.uniq!
            $pl = $u_p_files > 1
            puts " Unexpected passes were found in the following #{pl "file"}:"
            $u_p_files.each do |pass|
                puts "  #{pass}"
            end
        end
        $pl = $nok > 1
        puts " #{$nok} #{pl "test"} failed, #{$expected_failures} of which were expected."
        unless $unexpected_failures.empty?
            $unexpected_failures.uniq!
            $pl = $unexpected_failures.size > 1
            puts " Unexpected #{pl "failure"} #{were} found in the following #{pl "file"}:"
            $unexpected_failures.each do |fail|
                puts "  #{fail}"
            end
        end
        $pl = $missing_files.size > 1
        unless $missing_files.empty?
            puts " There #{were} #{$missing} test #{pl "file"} that reported fewer results than were planned:"
            $missing_files.uniq!
            $missing_files.each do |missing|
                puts "  #{missing}"
            end
        end
        $pl = $toomany_files.size > 1
        unless $toomany_files.empty?
            puts " There #{were} #{$toomany} test #{pl "file"} that reported more results than were planned:"
            $toomany_files.uniq!
            $toomany_files.each do |toomany|
                puts "  #{toomany}"
            end
        end
        $pl = $unknown > 1
        puts " There #{were} #{$unknown} unknown or confusing #{pl "result"}." if $unknown > 0
        $pl = $failures > 1
        puts " There #{were} #{$failures} complete #{pl "failure"}." if $failures > 0
        $pl = $issue_lacks.size > 1
        unless $i_l_files.empty?
            puts " There #{were} #{$issue_lacks} #{pl "test"} that used todo or skip without noting an issue number, found in:"
            $i_l_files.uniq!
            $i_l_files.each do |file|
                puts "  #{file}"
            end
        end
        puts " -- CLEAN FOR COMMIT --" if clean?
    end

    task :stats => [:all] do
        $pl = $issue_counts.size > 1
        unless $issue_counts.empty?
            puts " The following #{are} the #{pl "issue"} currently known to affect the tests, and a count of the fails associated with #{them}:"
            $issue_counts.each do |issue, count|
                $pl = count > 1
                puts "  Issue ##{issue}: #{count} #{pl "fail"}"
            end
        else
            puts " There are no issues currently known to affect the tests."
        end
    end
end
