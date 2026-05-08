# DFD Legend Excerpt

This sample DFD uses the standard review grammar:

- Flow-label grammar: `<flow name> / <C#>,<T#>,<IA#|SA#|CA#>,<AZ#|AZ?>`
- Data-store grammar: `<class> • <R#> • <Enc|Tok|Mask|Clr|Unknown>`

## Marker meanings

- `C#` = data class
- `T#` = transport protection
- `IA#` = interactive / user authentication
- `SA#` = service authentication
- `CA#` = client / customer authentication
- `AZ#` = authorization visibly present / proven
- `AZ?` = authorization not visibly proven / unknown
- `R#` = residency / replication / region marker
- `Enc` = encrypted at rest
- `◇ / S#` = security-control / security-stack signal
- `[HITL]` = human-in-the-loop approval gate
- `AAL-L1..L4` = AI Action Level scale

## Rule reminder

Authentication does **not** imply authorization.
If authorization is not visibly proven on a flow, use `AZ?`.
