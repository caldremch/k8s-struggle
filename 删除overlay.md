由于修改了kubespray中的containerd地址, 然后需要删除原本的容器目录节省空间,
```text
root@k8s-master:/run# rm -rf containerd
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/204157b37c46c349739ecc2c3b1937e7b4a4a0c53fb20754691aeaad5b7c69d9/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/0af3acd5434ce3fe316711d3683443b4efaa6b4342011a8408ae1c04a1a472da/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/df330ed29983c2ea78a62765fab6dd5c55fefcd6dc97149472fd178bc905e316/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/9f9a93497c82faca948779e51745c84db9df5a9fd37b3e8529904d33a6b142c6/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/0578b3d6d3b1cc749fa5fef2caf099c850000c7a07f54a94bbbf820e96dd08a0/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/59964daa05c88ca4381d8b5ed074aa80edd092b4fcf0ebd2fb2f88194999e358/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/17b0b41bc79cbe832c7562ff0b40b5ed20d063099b6bd535b6f48f62f514f0ce/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/c7367f1139876400d5374954051bfa4bc609145ee684d068a998b7d2b25b6794/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/0a2a30891f23b75c4a0521427835ab0effd898dc6f8b601abd0a0d3313115e72/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/42657081319ecad673b7b032c2484c8f99ecbd9e61062dd4709508cc6678cdab/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/032a88bc897d84d2881db3359a9c28f6a47b5eb976e77a9e3d9e689e5080049c/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/27b070a16741cece48c3b29d032ea8423b6e1a930471da6a6741ce0cb04ec155/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/9cfd98e3c9f71b5269a9a94c718845049e91894c195470d43746539cad8de595/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/e8cbf0c37b0902303a7c1ae8c30e238d64e9748d2977042c0db8af8b22ca1a02/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/3fc536dc874c2863490c220bace3d9f59846a6d9c9c9f43f37372cf9340b9aa6/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/d07937bd68f78a1117be865f61ea2aef7e1a8ac69f3ea16b1635bbda9231578c/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/178ee1b12650eea37d7989d562e6f8306dbfdab1205d494e1f383dfb079b5956/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/98cf816f532f5c23089866e65273dae71882c8353780fff2e1ed4805df3802b4/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/85f1effefd3782a50be118cc048371c54762306255fe45a6a1fbdf4c1ccff303/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/1798a0cabeabe02bf10e85f6b19fef9f36e396fbf964bfda91c404dacc546b82/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/f6a3fc6c2b83175fa366fc51cee9e61979a2399aa5f0fb1a4703572d25e3da9e/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/5cc65e1e6d4962873c15770a0f3b02f741996afd95af607728a666950c24d316/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/44df3b85c050322f04eaac304bf5888fce4473b21617e1a4f3ad48968001704f/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.grpc.v1.cri/sandboxes/89a02cb7e852813b2cd9f84dc488e1257ef01fdf4cd33aaaec6a9da272bef28a/shm': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/700f217aedbf5f130efe4ab9a5744cc40bca976383b4dc7d0b8ba42a16a588ec/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/ce8f6a024f9ec0165dcaefda9d35167f26555b8918cbf112c7b840aa6255b651/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/bf06104b4ae50dc08b96fae11baad6cb6ae06beb7c4751d2ef8d90013c963949/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/0097333628b4182cc45a22f269d25f62332f821706db857e7516b1d6ea6a8808/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/cf5072aab90b0b120dfdc25b6b01d3b184c84df299c6967909b748fcf35c9823/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/4af86acef202cdde38c399c8c583fc40673cbfa5f742f93efb5d22fa505e86d3/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/0229ee015c15fb91dc89e5394bee5e036ab7f42e2bfc7d77d6c514838da37d6d/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/caeb0edcc5e21014573c3d9eb4ba472ec845703831e300ec27f1bd2fa19b1352/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/69a83866417f15477a52a84633e3a67355d54b57d4a62c023065428074764264/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/07551eb2345daeb9c6c252cbec174203a88de34b23ebd00418b8edcd305c06bc/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/b4f4d6bbe56fc8a3a138cd46945715d28723a4f1ff59ba837c1e5e4752511bda/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/c89b904b214bad4e837ad219909d17731ee3d3885281bb494f7aff4468946819/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/204157b37c46c349739ecc2c3b1937e7b4a4a0c53fb20754691aeaad5b7c69d9/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/0af3acd5434ce3fe316711d3683443b4efaa6b4342011a8408ae1c04a1a472da/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/df330ed29983c2ea78a62765fab6dd5c55fefcd6dc97149472fd178bc905e316/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/9f9a93497c82faca948779e51745c84db9df5a9fd37b3e8529904d33a6b142c6/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/0578b3d6d3b1cc749fa5fef2caf099c850000c7a07f54a94bbbf820e96dd08a0/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/59964daa05c88ca4381d8b5ed074aa80edd092b4fcf0ebd2fb2f88194999e358/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/17b0b41bc79cbe832c7562ff0b40b5ed20d063099b6bd535b6f48f62f514f0ce/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/c7367f1139876400d5374954051bfa4bc609145ee684d068a998b7d2b25b6794/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/42657081319ecad673b7b032c2484c8f99ecbd9e61062dd4709508cc6678cdab/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/0a2a30891f23b75c4a0521427835ab0effd898dc6f8b601abd0a0d3313115e72/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/032a88bc897d84d2881db3359a9c28f6a47b5eb976e77a9e3d9e689e5080049c/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/6865b593e0a7d56a2293e00b36d41f622cbe5a8f7211866c222c75ef817ca6ea/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/27b070a16741cece48c3b29d032ea8423b6e1a930471da6a6741ce0cb04ec155/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/efb393acc13e51dca0960b2bb060d90e724ac557e1a9ff63e8cfe0120f69f3d7/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/9295ebc9ea36eac7795707cff81254eade891785fef51ae95209ce99e8372e6f/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/74880a5764f87a6ece981b9da1174150b1572d26629f025c256f48721212f57a/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/9cfd98e3c9f71b5269a9a94c718845049e91894c195470d43746539cad8de595/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/e8cbf0c37b0902303a7c1ae8c30e238d64e9748d2977042c0db8af8b22ca1a02/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/3fc536dc874c2863490c220bace3d9f59846a6d9c9c9f43f37372cf9340b9aa6/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/f5576fff3c8c011a658a77025cc966393be027fc1c686e816385eb7069691a2d/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/d07937bd68f78a1117be865f61ea2aef7e1a8ac69f3ea16b1635bbda9231578c/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/934bbd7d8cd2b2ea65e06c211b2a8b8f77ae0407fa93e9a0801d70e7f5cfdaaa/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/178ee1b12650eea37d7989d562e6f8306dbfdab1205d494e1f383dfb079b5956/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/71c25c3147cdf2ab3520e31d3df83d9e2577c1f7255d2059207cd9589b4ab52f/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/98cf816f532f5c23089866e65273dae71882c8353780fff2e1ed4805df3802b4/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/ae925e114f491ef24c569e48bf85b86583fcfe09a333551db1f4337f7c0640b2/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/85f1effefd3782a50be118cc048371c54762306255fe45a6a1fbdf4c1ccff303/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/df81e9a166a8f344bb8ca94e962f35799f402e1463a2034ba4076efc7d673283/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/1798a0cabeabe02bf10e85f6b19fef9f36e396fbf964bfda91c404dacc546b82/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/3b55cf9831a284b93a1d33fcec70a585ee1c922eeaab43a1d9dfeea6ac7168b7/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/f6a3fc6c2b83175fa366fc51cee9e61979a2399aa5f0fb1a4703572d25e3da9e/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/7b5680e4b4151481d2ad78359a96363f92e86eed54095de14f45292beab4109b/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/55bfe63fe006f1c5aeb74b63fa11ad320858fee7b78dee9d4e5ab8a86da5ad5d/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/5cc65e1e6d4962873c15770a0f3b02f741996afd95af607728a666950c24d316/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/44df3b85c050322f04eaac304bf5888fce4473b21617e1a4f3ad48968001704f/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/e68a09bb9f8a487949a4cc2c717107eb6d1f8cb029c0560832c0b14140bfe115/rootfs': Device or resource busy
rm: cannot remove 'containerd/io.containerd.runtime.v2.task/k8s.io/89a02cb7e852813b2cd9f84dc488e1257ef01fdf4cd33aaaec6a9da272bef28a/rootfs': Device or resource busy
```
但是报错:  Device or resource busy

# 解决思路

1. 需要先取消挂载, 这个后面记录的, 不记得了, 可以查一下
