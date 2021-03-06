import Principal "mo:base/Principal";

actor Lock {
    type LockActor = actor {
        add1 : () -> async Nat;
    };
    var a : Nat = 0;
    var n : Nat = 0;
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

    public func addN() : async (Nat,Nat) {        
        a += 1;
        n += 1;
        let handler : actor { addN : () -> async (Nat,Nat) } = actor(Principal.toText(Principal.fromActor(Lock)));
        if (n >= 5) { return (a, n); };
        let _ = await handler.addN();
        return (a, n);
    };

    public query func get() : async Nat {
        return a;
    };

    public query func getn() : async Nat {
        return n;
    };    
};
