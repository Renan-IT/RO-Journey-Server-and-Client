go to db/
comment :  `Mode: Renewal`
from `item_randomopt_db.yml` `item_randomopt_group.yml`
go to db/pre-re
edit : mob_db.yml
```
- Id: 1002
    AegisName: PORING
    Name: Poring
    Level: 1
    Hp: 50
    BaseExp: 2
    JobExp: 1
    Attack: 7
    Attack2: 10
    MagicDefense: 5
    Int: 0
    Dex: 6
    Luk: 30
    AttackRange: 1
    SkillRange: 10
    ChaseRange: 12
    Size: Medium
    Race: Plant
    Element: Water
    ElementLevel: 1
    WalkSpeed: 400
    AttackDelay: 1872
    AttackMotion: 672
    ClientAttackMotion: 288
    DamageMotion: 480
    Ai: 02
    Drops:
      - Item: Jellopy
        Rate: 7000
      - Item: Knife_
        Rate: 100
        RandomOptionGroup: AS_WEAPON_4  # <- Add random option group
      - Item: Sticky_Mucus
        Rate: 400
      - Item: Apple
        Rate: 1000
      - Item: Empty_Bottle
        Rate: 1500
      - Item: Apple
        Rate: 150
      - Item: Unripe_Apple
        Rate: 20
      - Item: Poring_Card
        Rate: 1
        StealProtected: true
```
