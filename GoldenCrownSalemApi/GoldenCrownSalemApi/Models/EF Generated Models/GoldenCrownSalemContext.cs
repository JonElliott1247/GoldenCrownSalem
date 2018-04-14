using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace GoldenCrownSalemApi.Models
{
    public partial class GoldenCrownSalemContext : DbContext
    {
        public virtual DbSet<Category> Category { get; set; }
        public virtual DbSet<CombinationPlateItem> CombinationPlateItem { get; set; }
        public virtual DbSet<FamilyDinnerItem> FamilyDinnerItem { get; set; }
        public virtual DbSet<MenuItem> MenuItem { get; set; }
        public virtual DbSet<MenuItemCombinationPlateItem> MenuItemCombinationPlateItem { get; set; }
        public virtual DbSet<MenuItemFamilyDinnerItem> MenuItemFamilyDinnerItem { get; set; }
        public virtual DbSet<SpicyOption> SpicyOption { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer(@"Server=(localdb)\mssqllocaldb;Database=GoldenCrownSalem;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__Category__EDBE0C588A5D0BD6")
                    .IsUnique();

                entity.Property(e => e.Description)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CombinationPlateItem>(entity =>
            {
                entity.ToTable("CombinationPlateItem", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__Combinat__EDBE0C580A23FE6E")
                    .IsUnique();

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.HasOne(d => d.DefaultSpicyOption)
                    .WithMany(p => p.CombinationPlateItem)
                    .HasForeignKey(d => d.DefaultSpicyOptionId)
                    .HasConstraintName("FK__Combinati__Defau__26F0871D");
            });

            modelBuilder.Entity<FamilyDinnerItem>(entity =>
            {
                entity.ToTable("FamilyDinnerItem", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__FamilyDi__EDBE0C58BC550255")
                    .IsUnique();

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.HasOne(d => d.DefaultSpicyOption)
                    .WithMany(p => p.FamilyDinnerItem)
                    .HasForeignKey(d => d.DefaultSpicyOptionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__FamilyDin__Defau__1C72F8AA");
            });

            modelBuilder.Entity<MenuItem>(entity =>
            {
                entity.ToTable("MenuItem", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UniqueLabelIndex")
                    .IsUnique()
                    .HasFilter("([SubLabel] IS NULL)");

                entity.HasIndex(e => new { e.Label, e.SubLabel })
                    .HasName("UniqueLabelSubLabelIndex")
                    .IsUnique();

                entity.Property(e => e.Description)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Price).HasColumnType("money");

                entity.Property(e => e.SubLabel)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.MenuItem)
                    .HasForeignKey(d => d.CategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MenuItem__Catego__16BA1F54");

                entity.HasOne(d => d.DefaultSpicyOption)
                    .WithMany(p => p.MenuItem)
                    .HasForeignKey(d => d.DefaultSpicyOptionId)
                    .HasConstraintName("FK__MenuItem__Defaul__17AE438D");
            });

            modelBuilder.Entity<MenuItemCombinationPlateItem>(entity =>
            {
                entity.HasKey(e => e.MenuItemFamilyDinnerItemId);

                entity.ToTable("MenuItem_CombinationPlateItem", "Menu");

                entity.HasOne(d => d.CombinationPlateItem)
                    .WithMany(p => p.MenuItemCombinationPlateItem)
                    .HasForeignKey(d => d.CombinationPlateItemId)
                    .HasConstraintName("FK__MenuItem___Combi__2AC11801");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.MenuItemCombinationPlateItem)
                    .HasForeignKey(d => d.MenuItemId)
                    .HasConstraintName("FK__MenuItem___MenuI__29CCF3C8");
            });

            modelBuilder.Entity<MenuItemFamilyDinnerItem>(entity =>
            {
                entity.ToTable("MenuItem_FamilyDinnerItem", "Menu");

                entity.HasOne(d => d.FamilyDinnerItem)
                    .WithMany(p => p.MenuItemFamilyDinnerItem)
                    .HasForeignKey(d => d.FamilyDinnerItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MenuItem___Famil__2043898E");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.MenuItemFamilyDinnerItem)
                    .HasForeignKey(d => d.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MenuItem___MenuI__1F4F6555");
            });

            modelBuilder.Entity<SpicyOption>(entity =>
            {
                entity.ToTable("SpicyOption", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__SpicyOpt__EDBE0C58CDE3098C")
                    .IsUnique();

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });
        }
    }
}
