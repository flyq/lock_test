import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory as lock_dfx_idl, canisterId as lock_dfx_id } from 'dfx-generated/lock_dfx';

const agent = new HttpAgent();
const lock_dfx = Actor.createActor(lock_dfx_idl, { agent, canisterId: lock_dfx_id });

document.getElementById("clickMeBtn").addEventListener("click", async () => {
  const name = document.getElementById("name").value.toString();
  const greeting = await lock_dfx.greet(name);

  document.getElementById("greeting").innerText = greeting;
});
