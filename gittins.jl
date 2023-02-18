γ = 0.9
T = 50
αₘ = T-1
βₘ = T-1  # max β (equal to max α)
Δp = 0.0001

R = zeros((αₘ, βₘ))
G = zeros((αₘ, βₘ))

for α in range(1, αₘ)
    R[α, T-α] = α/T
end

for p in Δp/2:Δp:1

    Vₚ = p/(1-γ)

    for t in βₘ:-1:2

        for α in 1:t-1

            Vᵣ = α/t * (1 + γ * R[α+1, t-α]) + (t-α)/t * (γ * R[α, t-α+1])

            if (G[α, t-α] == 0.0) && (Vₚ >= Vᵣ)
                G[α, t-α] = p - Δp/2
            end

            R[α,t-α] = maximum([Vₚ, Vᵣ])

        end

    end

end

display(G[1:10, 1:10])
