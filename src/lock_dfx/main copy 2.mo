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
        return (result, a);
    };

    public query func get() : async Nat {
        return a;
    };
};