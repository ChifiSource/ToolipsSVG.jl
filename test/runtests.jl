using Test
using ToolipsSVG

@testset "ToolipsSVG" verbose = true begin
    @testset "svg components" verbose = true begin
        @testset "const components" begin
            new_rect = rect("sample", text = "hello")
            linetest = line("sampleline")
            gtest = g("test", text = "hello")
            @test typeof(new_rect) == Component{:rect}
            @test typeof(linetest) == Component{:rect}
            @test gtest[:text] == "hello"
        end
        @testset "SVG shapes" begin
            mystar = star("samplestar", x = 5, y = 5)
            @test typeof(mystar) == Component{:star}
            set_position!(mystar, 10, 11)
            @test mystar[x] == 10
            polysh = polyshape("samplepoly")
            @test typeof(polysh) == Component{:polygon}
            @test polys.tag == "polygon"
        end
    end
    @testset "size and position" begin

    end
end