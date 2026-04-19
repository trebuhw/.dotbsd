# FreeBSD i optymalizacja pod SSD

FreeBSD domyślnie działa poprawnie na SSD, ale kilka ustawień warto dostosować, żeby wydłużyć żywotność dysku i poprawić wydajność.

---

## 1. TRIM / `autotrim`

Najważniejsza opcja. Włącz TRIM dla partycji UFS lub ZFS:

**ZFS:**
```bash
zpool set autotrim=on zroot
```

**UFS** – w `/etc/fstab` dodaj opcję `trim`:
```
/dev/ada0p2  /  ufs  rw,trim  1  1
```

---

## 2. Scheduler I/O

FreeBSD używa domyślnie schedulera `kern.sched` – dla SSD warto sprawdzić czy nie jest ustawiony `CAM`:

```bash
sysctl kern.geom.sched.algo
```

Dla SSD lepszy jest brak kolejkowania (noop-like) lub `rr`. Możesz wyłączyć zbędne schedulery.

---

## 3. `noatime` – wyłączenie aktualizacji czasu dostępu

Redukuje liczbę zapisów na dysk:

**`/etc/fstab`:**
```
/dev/ada0p2  /  ufs  rw,trim,noatime  1  1
```

---

## 4. ZFS – dostrojienie pod SSD

Jeśli używasz ZFS:

```bash
# Wyłącz zbędne synchronizacje dla mniej krytycznych danych
zfs set sync=disabled zroot/tmp

# Rozmiar recordsize (domyślnie 128K – dla baz danych zmniejsz do 8K)
zfs set recordsize=8K zroot/db

# Wyłącz atime
zfs set atime=off zroot
```

---

## 5. `vfs.read_max` i `vfs.write_max`

Zwiększenie buforowania I/O:

```bash
# /etc/sysctl.conf
vfs.read_max=128
```

---

## 6. Swap na SSD – ograniczenie zapisów

Jeśli swap jest na SSD, rozważ:
- Zmniejszenie `swappiness` (FreeBSD: `vm.swap_idle_enabled=0`)
- Użycie `swap` na osobnej partycji z włączonym TRIM

---

## Podsumowanie priorytetów

| Optymalizacja | Ważność |
|---|---|
| TRIM (`autotrim`) | ⭐⭐⭐ konieczne |
| `noatime` | ⭐⭐⭐ zalecane |
| ZFS `atime=off` | ⭐⭐⭐ zalecane |
| Scheduler I/O | ⭐⭐ opcjonalne |
| ZFS `recordsize` | ⭐⭐ zależnie od użycia |

Najważniejsze to **TRIM + noatime** – reszta to fine-tuning w zależności od przypadku użycia.
