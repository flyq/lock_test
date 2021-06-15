import Principal "mo:base/Principal";

actor Lock {
    type LockActor = actor {
        add1 : () -> async Nat;
    };
    var a : Nat = 1;
    public func add1() : async Nat {
        a += 1;
        return a;
    };

    public func add2() : async (Nat,Nat) {        
        let handler : LockActor = actor(Principal.toText(Principal.fromActor(Lock)));
        let result = await handler.add1();
        a += 1;        
        return (result, a);
    };

    public func addN() : async Nat {        
        let handler : actor { addN : () -> async Nat } = actor(Principal.toText(Principal.fromActor(Lock)));
        let result = await handler.addN();
        a += 1;        
        return a;
    };

    public query func get() : async Nat {
        return a;
    };
};
