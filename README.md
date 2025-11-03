# 💻 DevNet ~ Set up your own dev machines & server! 👩‍💻👨‍💻

A "DevNet" is a set of machines, likely laptops, comprising their own network to facilitate software development with (at least) one of those machines being a server for Git, ChatOps (like Mattermost), etc., as well as for more basic things like DHCP, SCP, and DNS.
The idea is to have a local setup as self-sufficient as possible that can pair with web/cloud tools like GitLab, and yet is robust against cloud, Internet, and power outages, putting control in the hands of the organization/developers, lessening the grip of vendor lock, and eliminating unnecessary cloud expenses.

Welcome to the DevNet project. Here I document how to create your own DevNet and clone/image the machines thereof to minimize setup work. Configuration files are provided to copy-and-paste, though several require editing per instructions.
The how-to's in this project are pretty flexible. Very often, you can substitute your preferred software.

# 🧩 The problems we're solving 🧑‍🔧

**As a** developer new to an organization,  
**I want** a development machine, right off the bat, that's as ready-to-go as possible for my new job,  
**So that** I can spend my time doing what I love, and not have 3 weeks of figuring out which software I need and troubleshooting how to install and configure it.

🌿

**As an** organization with plenty of spare machines (probably laptops), all of which are standard-configured\*, and who has a network and Internet connection that only allow said machines,  
**I want** step-by-step instructions on how to reconfigure existing machines for development purposes (to include admin rights for developers) and give them their own network, Internet access, and whatever else they need,  
**So that** my developers have physical machines to do their work on without remoting into some other machine,

- Avoiding the lag and occasional unavailability inherent to remote development machines,
- Ensuring continuity of development in the event of a cloud service, Internet, and/or power outage,
- Avoiding the cost of any remote development machines in the cloud,
- Ensuring that my developers have the best OS for their job, which may differ from what the available remote machines have,
- Minimize vendor lock with whoever would have provided (or is currently providing) said remote machines (Azure, AWS, etc.),
- Minimize vendor lock with whichever Git repository suite I'm currently using (GitLab, BitBucket, etc.),
- And make sure that innovation is as unimpeded as possible: devs have admin rights to install and try new technologies.

\* Or spring-loaded to become standard-configured, or at least require access to my network to activate Windows. But again, they're only allowed on my existing network if they are standard-configured, with the possible exception of if they are in the process of becoming standard-configured.

**As a** developer who only has access to standard-configured machines and who does not have admin rights to them,  
**I want** step-by-step instructions to [ditto], and with as little need for admin privileges as possible (admin privileges to a pre-existing OS installation, that is),  
**So that** I can do my job in a timely, appropriate, enabled, and robustly reliable fashion.

# ↔️ Supported options

- Windows development machines
  - I specifically address hurdles with Windows Enterprise: activation without access to your activation server and getting the first local account without Active Directory.
    - If you do not have Windows Enterprise, then you get to skip those bits. ☺️
- Linux development machines.
  - The provided instructions suggest the KDE spin of Fedora Linux. But you can adjust to your distro/spin of choice.

🌿

- Remember, the instructions produce machines with where the recipients have admin/root privileges and where the system state has been rebuilt by you from fresh OS install and cloned thereafter.
- For the Linux instructions, you **do not need any admin rights** to any pre-existing Windows installation.
  - You will, however, likely be confronted with an EFI password prompt (EFI being the successor to BIOS). Barring hardware work such as motherboard replacement or soldering/chip-flashing, satisfying any such password prompt is necessary to disable so-called "secure boot" to boot Linux. While you're at it, you might as well enable USB booting to install Linux from a bootable flash drive and/or use Clonezilla for imaging/cloning, etc. There's a good chance the password is some default like "admin", "password", or "root". It may also be possible that simply hitting enter goes right past the prompt.
- At time of writing, the Windows option only requires admin privileges to the pre-existing Windows installation if BitLocker is off and you choose to activate your copy of Windows, which is not strictly required, but is recommended for the appearance of legitimacy and professionalism (to remove the watermark without shady means), and these **admin privileges are only needed once every 180 days** for Enterprise licenses, and only for a single step: to make a backup copy of the activation data to allow offline reactivation after reinstalling Windows.

# 🛤️ Where I support, but don't give options

- Server. I use Linux.
  - Again, the instructions go with Fedora. If you want commercial support, Red Hat (RHEL) is a drop-in replacement, as Red Hat is a derivative product ("downstream") of Fedora (hence the name) that is more tested and comes with customer support. Alternatively, you can adapt the instructions to your distro of choice.
- Bootable flash drive. I use Ventoy. For installing Linux and imaging/cloning. And possibly for backing up Windows activation data if BitLocker is off.
- Dealing with EFI settings. (You might still call this "the BIOS".) Not much of an alternative here anyways, unless you want to replace the motherboard or do some soldering.

# 🔩 Hardware

_Daggers_ (†) _indicate products I actually used for the DevNet I created._

## The meat and potatoes 🥩🥔

- At least 2 machines, likely laptops. One to be a server, the other to be a development machine.
- At least 2 high-speed [flash drives†](https://www.amazon.com/dp/B09HJL9655). One for booting into the Linux installers and Clonezilla, one for files.
  - In theory, the more flash drives, the more workstations you can clone at once. In practice, attempting to do more than 3 or so in parallel will feel like spinning plates, especially if you're teaching others how to do it at the same time. SSDs are so fast these days that getting through the Clonezilla prompts and doing one-time set up, such as enabling drive encryption, and, if the recipient is present, having them change their password and generate/save a GitLab token, etc., is a very significant percentage of the total time. So it's not so much "hit buttons and let them run" as it is "try to keep up with them".
- Ethernet cables. Note that with a gigabit switch, I anticipate no benefit of CAT 6 over CAT 5. In the long run, buying CAT 5 in bulk (a spool) and making your own cables is the most economical option, with _**bulk**_ CAT 5 having a significant cost savings over bulk CAT 6. Yet, you might find a pre-made CAT 6 cable of a given length cheaper than the same length of pre-made CAT 5! Also, CAT 5 is easier to terminate, not having a "spine" to work around. However, you'd be hard-pressed to meet the termination quality of a commercially-manufactured cable, especially if you want clips that don't break so easily. Assuming you're starting fairly small to where making your own isn't worth the effort, I give links to ready-made cables below. Amazon Basics Ethernet cables have been great for me thus far. KabelDirekt is a cheaper option that will still get the job done, but they might not be available in the size you're looking for at time of purchase. Maybe Amazon Basics has more robust clips, as I have had clips break on a KableDirekt but not on Amazon Basics. But I was unplugging and plugging the former much more, so, I really don't know. If I recall correctly, in a single room, I used:
  - 6 [50-foot cables†](https://www.amazon.com/dp/B0134QJH4G) -- 1 for the printer and 5 "distant" drops for DevNet workstations
    - Cheaper [KabelDirekt alternative](https://www.amazon.com/KabelDirekt-Network-Cable-Transmits-Fiber-Optic/dp/B016A90XOW)
  - 2 [2-foot†](https://www.amazon.com/dp/B002RBECAE) cables -- 1 to connect the server's dock to the switch, one to connect to the LTE modem. Being transparent, I actually had one black and one red. Color coding seemed cool in the moment. In hindsight, pretty unnecessary. There's only one short Ethernet cable when not using the modem.
    - [KabelDirekt 3-foot alternative](https://www.amazon.com/KabelDirekt-Network-Cable-Transmits-Fiber-Optic/dp/B016A90W3Y). Don't know if it's cheaper. Probably is. (price only shown when available)
  - 1 [14-foot†](https://www.amazon.com/dp/B00N2VJ2CG) cable -- For a closer workstation
    - [KabelDirekt 15-foot alternative](https://www.amazon.com/KabelDirekt-Network-Cable-Transmits-Fiber-Optic/dp/B016A90R3Y)
- [LTE modem](https://www.amazon.com/dp/B09PBP1F1F)
- Pre-paid _data&#x20;_[sim card](https://www.amazon.com/dp/B0C9PFK49P)
- [UPS†](https://www.amazon.com/dp/B07RWMLKFM) (uninterruptible power supply)
- [Unmanaged switch†](https://www.amazon.com/dp/B00023DRLO) (comes with the benefit of not having to be managed, and it's probably more secure than a managed switch)

## Keyboard, video, mouse (aka "KVM") 🖥️🖱️

_These items are technically optional, unless you have a bad touchpad/touchpad driver. Then you at least need a mouse._  
_Also consider if you wish to build a pair programming station while you're at it. Very handy for co-learning, as well as for demoing your DevNet._  
_I'll document how to build a pair programming station in another project, but know it uses more KVM switches and cables. You may also want under-desk keyboard and mouse trays for that._

- At least one keyboard
  - My office had plenty of these around.
- At least one [mouse†](https://www.amazon.com/dp/B086MFKYZB)
  - The ability to switch from smooth and fast scrolling to line-by-line scrolling is second nature to me at this point. Had this model since at least 2019 and still love it.
- At least one monitor
  - Again, my office had plenty of these.
- At least one [KVM switch†](https://www.amazon.com/dp/B0BLH7MBWM) to go from your org's standard-configured machine and network to your DevNet machine and network, and vice versa. (Note the KVM switch itself does not actually touch either Ethernet cable.)
  - If you have DisplayPort and want multiple monitors, to save money and reduce cables, you may consider putting a DisplayPort hub on the monitor side of a single-monitor KVM switch instead of either using 1) a double/triple-monitor KVM switch or 2) two or three single-monitor KVM switches in tandem acting as one double- or triple-monitor KVM switch. **However**, if you want a pair programming station, you might decide against the hub method, explained below. Also, I have not tested the hub method. However, [this](https://www.displayport.org/cables/driving-multiple-displays-from-a-single-displayport-output/) looks promising -- you probably(?) won't lose any signal quality with a DisplayPort hub.
  - If you wish to build a pair programming station, which splits the video feed to two sets of monitors, and you have DisplayPort, I recommend adapting from that to DVI and splitting the DVI (using powered splitters only!). Why? Well, let's use this example: say you want both seats of the pair programming station to have dual monitors for 4 total monitors, both seats having the same video feed, their own mouse, and their own keyboard, all going to the same DevNet laptop, or to the same standard-configured laptop, depending which you have selected with your KVM switch (or multiple KVM switches acting as one). If you were to instead directly split DisplayPort with one KVM switch and one 4-port hub or with 2 KVM switches, both going to both machines, and 2 2-port hubs, the applicable laptop would see all 4 monitors and you'd have to keep configuring them in your display settings, assuming you move your laptop around from setup to setup. By instead splitting DVI, the laptop only sees two monitors that you configure as an extended (not mirrored) display. So that way, you have less to configure and you avoid the difficulty (maybe even impossibility) of having to both mirror and extend simultaneously. Also, I doubt more than one DVI monitor would work on a DisplayPort hub (even with adapters), at least not well. So I shied away from using any DisplayPort hubs, given my pair programming setup.
  - You can save money by sticking together two or three single-monitor KVM switches, as compared to the price of one double- or one triple-monitor switch.
    - If you're going this route, you will almost certainly want a [headphone splitter†](https://www.amazon.com/dp/B07K9RDMCZ). That way, you can control both or all three with one button press, provided all your KVM switches are the same, or at least button-compatible, which might require them to all be DisplayPort or all DVI, etc. I have tested and confirmed that the headphone splitter method works with the linked KVM switch. Be careful to not accidentally get a splitter that separates microphone and headphones; that won't work. You want a splitter that traditionally would be used to let two or three people listen to the same music.
    - Your dock might only have two similar video ports and one dissimilar. This was my case: 2 DisplayPort, 1 HDMI. And I wanted 3 monitors. Since I knew I'd already be adapting to DVI for splitting, I wanted to avoid double-adapting from HDMI to DisplayPort and then from that to DVI, as I was worried that'd unnecessarily loose signal quality or otherwise introduce jankiness by double-adapting. In hindsight, I should have just double-adapted. By avoiding double-adapting, I forced myself into jankiness: every time I wanted to switch, I had to do 2 things instead of one: hit the button for the two DisplayPort KVM switches (using the headphone splitter) and use the IR remote for the DVI KVM switch (I directly adapted from HDMI to DVI before the KVM switch). I tried connecting the DVI KVM switch to the third plug of the headphone splitter, but it does not respond to the signal produced by the button from the model of DisplayPort KVM switch I was using. And the DVI KVM switch didn't even come with a wired remote button. You have to use the IR sensor. Had I double-adapted, I could have had three identical KVM switches off the same button.
  - As far as cables, the linked KVM switch assumes you already have one video cable and one monitor power cord and provides the remaining necessary cables, on a per-monitor basis, as this is a single-monitor KVM switch. It gets power from USB, so if you're sticking 2 or 3 together and have your mice and keyboards all in one, don't forget to make sure the other KVM switches each get one of the provided USB cables just for power, despite the lack of USB devices on them. It may even help to label such cables as "Power" so they don't seem pointless.
- Consider: under-desk keyboard mount.
  - I scavanged my office building for these. You can get mounts that support both keyboard and mouse. I do like the "Banana Boards" I found. They have a banana-shaped insert that can slide to either side for right- or left-handed mouse use.
- Consider: under-desk [mouse pad†](https://www.amazon.com/dp/B09MTZ4B4F).
  - I paired these with other keyboard mounts I found, since I only found two Banana Boards.

## Mounts & basket 🪝📐

- [Under-desk mount for UPS†](https://www.amazon.com/dp/B08DDK44TY)
  - Ribbons couldn't get all the way tight with the UPS I used. I have no fears of the UPS falling down, though. Maybe you can find a better one.
- [Under-desk mount for server†](https://www.amazon.com/dp/B0C4J5XZ39) (assuming a laptop here)
- [Under-desk mount for server docking station†](https://www.amazon.com/dp/B0DL5GS88C) (again, assuming a laptop)
  - Linked mount is specifically for the dock I had. Get one appropriate for your dock, if you have one at all.
- [Under-desk basket for cords†](https://www.amazon.com/dp/B09L62NFJ2)

## Handyperson stuff 🪛

- [Face shield](https://www.amazon.com/dp/B088B969B5) recommended. You might go with safety glasses, which do not protect the eyes as thoroughly.
- Maybe: [ear protection](https://www.amazon.com/dp/B07QPQJYWR)
- [Drill†](https://www.lowes.com/pd/SKIL-PWR-CORE-12-Drill/5015401911)
  - Note: I kept the original box and battery dust cover. I use the OG box for storage and transport.
- [Drill bits†](https://www.amazon.com/DEWALT-DW1354-14-Piece-Titanium-Yellow/dp/B0045PQ762)
- Hand [screwdriver](https://www.amazon.com/WORKPRO-Screwdriver-Multi-purpose-Electrical-Screw-driver/dp/B09NX455H6). Some screw applications are too delicate for power tools.
  - **Note:** Get a screwdriver that comes with bits you can use in the drill.
  - Linked screwdriver is cheaper with Prime.
- [Screw extractor kit†](https://www.amazon.com/dp/B0BTNT4225). Just be prepared.
- Some way to pick up the shavings. Note that screw extraction produces _metal shavings_. For that, I'd recommend a bagged shop vac with eye and ear protection. I'd let it keep running for a bit after picking up the shavings while holding the hose up and straight with a little bit of a shake to make sure shavings aren't left in the hose, otherwise, they might fall out somewhere. But, if you are more limited in options, you might have to make do with a cheap/old vacuum and/or a lint roller. I would have reservations about sending metal shavings through my finest vacuum.
- A way to mount the switch (if you do at all)
  - If mounting under a desk, you do have the option of being a little barbaric, as I was, by wedging some flathead (countersunk) screws into the keyhole slots. This is a decently secure hold, though it might bend the metal housing of the switch a bit and probably mar paint around the slots. A benefit is that you don't have mounting brackets in your way or taking up under-desk space: you have clean access to the switch. I used flathead screws where the heads are an upside-down cone shape. When combined with keyhole slots, these heads act like wedges. If I recall correctly, the provided screws are "pan"-headed (flat-bottom heads), and thus do not provide an under-desk hold that is secure against being bumped.
    - Note: The cheapest way to get screws is to scavange for them. Perhaps you'll have some in a drawer or left over from cubicle rearrangement. Failing that, if you have a hardware store a reasonable distance from where you work, it is far more cost effective to get a couple screws there than to order a bunch online. At time of writing, Lowe's has the best deal on the particular drill I used. So if you actually go to a physical Lowe's for the drill, that's the time to get the screws.
  - You can wall mount with the provided kit, as long as you hang it vertically so that it's secured by gravity.
  - You *could* use 3M picture hangers or Command strips. If using either of these to mount under a desk, remember that you're using something intended to bear weight vertically, not along the Z-axis. So in that case, you'd need more than what the weight rating suggests. I'm not sure how secure that would be, but it wouldn't be as barbaric as wedging with flathead screws.
  - And finally, you can get a full mounting kit like what I link to for the laptop. The main downsides here are 1) you likely won't have totally clean access to the switch for both the power cable and Ethernet cables, and 2) a mounting bracket might collide with an under-desk keyboard mount when pushed in, or the bracket might turn out to be a knee-doinker if you're running short on under-desk space.

## Odds and ends 🪢📎

- [Labels for cables†](https://www.amazon.com/dp/B0B395DPZN). You don't want to confuse your org's network with DevNet. That could lead to a security incident, since only standard-configured machines are allowed on your org's network.
- [RJ-45 Plug protectors†](https://www.amazon.com/dp/B0B93GQJXY). So the clip doesn't break when the cable is not in use.
- [3M picture hangers†](https://www.amazon.com/dp/B073XR4X72). Similar to Velcro, but don't wear out as easily. To stick KVM switches together, as well as to the desk.
- [Command strips†](https://www.amazon.com/dp/B0751RPC6Q) to secure the KVM button/IR sensor to your desk.
- _Reminder that you might want spare/additional 3M command strips and picture hangers_
- [Tamper-evident seals†](https://www.amazon.com/dp/B072MDS4C2). Makes DevNet machines stand out to not be confused with standard-configured machines. Shows if anyone opened one up, provided you span them from the cover to the main case.
- [Shipping tape†](https://www.amazon.com/Scotch-Heavy-Shipping-Packaging-Clear/dp/B003W0P2SA) to cover tamper-evident seals, so the signature doesn't smudge.
- [Sharpie†](https://www.amazon.com/dp/B000A0S4YY) & [masking tape†](https://www.amazon.com/dp/B00004Z4CP) to mark where to put the screws for the switch's keyhole slot and to lay-out for the other mounts.
- [3x5 cards](https://www.amazon.com/AmazonBasics-Blank-Index-Cards-White/dp/B07X5CSNVH) or [printer paper](https://www.amazon.com/AmazonBasics-Multipurpose-Copy-Printer-Paper/dp/B01FV0F8H8) to label equipment as "DevNet"
  - You'd want 3x5 cards where at least one side is unruled.
- [Scissors](https://www.amazon.com/FISKARS-All-Purpose-Scissors-Performance/dp/B002YIP97K) to cut 3x5 cards/printer paper. Helpful for tape as well.
  - Alternatively, you can take a more elevated approach with a [paper cutter](https://www.amazon.com/Amazon-Basics-Guillotine-Heavy-Duty-10-Sheet/dp/B07LFH2MGH).
- [Pen](https://www.amazon.com/Pilot-Retractable-Premium-Roller-31250/dp/B003LTJFD0) to sign tamper-evident seals.

## Printer. The reason may surprise you. 🗳️

While you might not need a printer for practical reasons, you might need one for political reasons. If you're pitching the idea of a DevNet, and you want to show that no capabilities are lost, and specifically want to show that you only need a development machine and not both a dev machine and a standard machine, you'll need your DevNet to have a printer. (Only having one machine per dev saves your org cost going forward, not only in computers, but in KVM switches, etc.) Remember, your DevNet machines are not permitted on your organization's network, and therefore, do not have access to your organization's printers, unless you dedicate one for DevNet. Chances of finding an unused printer laying around can be pretty good.

Remember, it might be against code where you are to plug a printer into a cubicle outlet. Cubicles count as power strips. So be sure you have a [power cord long enough for your printer†](https://www.amazon.com/dp/B0728CMZSY).