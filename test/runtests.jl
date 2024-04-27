using Test
using ToolipsSVG
using ToolipsSVG.ToolipsServables

@testset "ToolipsSVG" verbose = true begin
    @testset "svg components" verbose = true begin
        @testset "const components" begin
            new_rect = rect("sample", text = "hello")
            linetest = line("sampleline")
            gtest = g("test", text = "hello")
            @test typeof(new_rect) == Component{:rect}
            @test typeof(linetest) == Component{:line}
            @test gtest[:text] == "hello"
        end
        @testset "SVG shapes" begin
            mystar = star("samplestar", x = 5, y = 5)
            @test typeof(mystar) == Component{:star}
            set_position!(mystar, 10, 11)
            polysh = polyshape("samplepoly")
            @test typeof(polysh) == Component{:polyshape}
            @test polysh.tag == "polygon"
        end
    end
    @testset "shape interface" verbose = true begin
        new_rect = rect("samplerect", width = 150, height = 450, x = 50, y = 50)
        @testset "size and position" begin
            init_circ = circle("sampelcirc", cx = 20, cy = 10, r = 5)
            set_size!(init_circ, 20, 20)
            @test init_circ[:r] == 20
            set_position!(init_circ, 5, 6)
            @test init_circ[:cx] == 5
            @test init_circ[:cy] == 6
            @test Tuple(string(s) for s in size(init_circ)) == ("20", "20")
            @test Tuple(string(s) for s in get_position(init_circ)) == ("5", "6")
            @test Tuple(string(s) for s in get_position(new_rect)) == ("50", "50")
            set_position!(new_rect, get_position(init_circ) ...)
            @test get_position(new_rect) == get_position(init_circ)
            set_size!(new_rect, size(init_circ) ...)
            @test size(new_rect) == size(init_circ)
        end
        @testset "set shape" begin
            star = set_shape(new_rect, :star)
            @test typeof(star) == Component{:star}
            circ = set_shape(star, :circle)
            @test typeof(circ) == Component{:circle}
            @test string(circ[:cx]) == "5"
        end
    end
end