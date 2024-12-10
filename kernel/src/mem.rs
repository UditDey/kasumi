pub mod arena;
mod heap;
mod rb_tree;

const SMALL_PAGE_SIZE: usize = 0x1000;
const LARGE_PAGE_SIZE: usize = 0x200_000;
const HUGE_PAGE_SIZE: usize = 0x4000_0000;

pub fn init() {
    use crate::{
        debug_print::{HEADING, SUBHEADING},
        debug_println,
    };

    use rb_tree::RBTree;

    heap::init();

    let mut tree = RBTree::new();

    tree.insert(2, 69);
    tree.insert(1, 420);
    tree.insert(3, 360);

    debug_println!("{:?}", tree.get(2));
    debug_println!("{:?}", tree.get(3));
    debug_println!("{:?}", tree.get(1));
    debug_println!("{:?}", tree.get(89));

    /*debug_println!("{:?}", heap::alloc_slot());
    debug_println!("{:?}", heap::alloc_slot());

    #[derive(Default, Debug)]
    struct Test {
        right: usize,
        left: usize,
        addr: usize,
        size: usize,
    };

    let mut arena = Arena::<Test>::new();

    debug_println!("{:?} {}", arena, Arena::<Test>::NODES_PER_SLOT);

    for i in 0.. {
        debug_println!("{} {:?}", i + 1, arena.alloc(Test::default()).unwrap());
    }

    let a = arena.alloc(Test::default()).unwrap();
    debug_println!("{:?}", a);

    let b = arena.alloc(Test::default()).unwrap();
    debug_println!("{:?}", b);

    arena.free(a);

    let c = arena.alloc(Test::default()).unwrap();
    debug_println!("{:?}", c);

    arena.free(b);
    arena.free(c);*/
}
