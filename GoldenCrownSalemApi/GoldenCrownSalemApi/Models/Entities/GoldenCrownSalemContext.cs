using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace GoldenCrownSalemApi.Models.Entities
{
    public partial class GoldenCrownSalemContext : DbContext
    {
        public virtual DbSet<Account> Account { get; set; }
        public virtual DbSet<Category> Category { get; set; }
        public virtual DbSet<CombinationPlateItem> CombinationPlateItem { get; set; }
        public virtual DbSet<FamilyDinnerItem> FamilyDinnerItem { get; set; }
        public virtual DbSet<MenuItem> MenuItem { get; set; }
        public virtual DbSet<MenuItemCombinationPlateItem> MenuItemCombinationPlateItem { get; set; }
        public virtual DbSet<MenuItemFamilyDinnerItem> MenuItemFamilyDinnerItem { get; set; }
        public virtual DbSet<Order> Order { get; set; }
        public virtual DbSet<OrderItem> OrderItem { get; set; }
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
            modelBuilder.Entity<Account>(entity =>
            {
                entity.ToTable("Account", "Sales");

  
                entity.Property(e => e.Hash).HasColumnType("binary(64)");

                entity.Property(e => e.UserName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FirstName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Salt).HasColumnType("binary(128)");
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__Category__EDBE0C58103C311F")
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
                    .HasName("UQ__Combinat__EDBE0C587C4DAC49")
                    .IsUnique();

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.HasOne(d => d.DefaultSpicyOption)
                    .WithMany(p => p.CombinationPlateItem)
                    .HasForeignKey(d => d.DefaultSpicyOptionId)
                    .HasConstraintName("FK__Combinati__Defau__2D729C23");
            });

            modelBuilder.Entity<FamilyDinnerItem>(entity =>
            {
                entity.ToTable("FamilyDinnerItem", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__FamilyDi__EDBE0C58F648D4C2")
                    .IsUnique();

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.HasOne(d => d.DefaultSpicyOption)
                    .WithMany(p => p.FamilyDinnerItem)
                    .HasForeignKey(d => d.DefaultSpicyOptionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__FamilyDin__Defau__22F50DB0");
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
                    .HasConstraintName("FK__MenuItem__Catego__1D3C345A");

                entity.HasOne(d => d.DefaultSpicyOption)
                    .WithMany(p => p.MenuItem)
                    .HasForeignKey(d => d.DefaultSpicyOptionId)
                    .HasConstraintName("FK__MenuItem__Defaul__1E305893");
            });

            modelBuilder.Entity<MenuItemCombinationPlateItem>(entity =>
            {
                entity.HasKey(e => e.MenuItemFamilyDinnerItemId);

                entity.ToTable("MenuItem_CombinationPlateItem", "Menu");

                entity.HasOne(d => d.CombinationPlateItem)
                    .WithMany(p => p.MenuItemCombinationPlateItem)
                    .HasForeignKey(d => d.CombinationPlateItemId)
                    .HasConstraintName("FK__MenuItem___Combi__31432D07");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.MenuItemCombinationPlateItem)
                    .HasForeignKey(d => d.MenuItemId)
                    .HasConstraintName("FK__MenuItem___MenuI__304F08CE");
            });

            modelBuilder.Entity<MenuItemFamilyDinnerItem>(entity =>
            {
                entity.ToTable("MenuItem_FamilyDinnerItem", "Menu");

                entity.HasOne(d => d.FamilyDinnerItem)
                    .WithMany(p => p.MenuItemFamilyDinnerItem)
                    .HasForeignKey(d => d.FamilyDinnerItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MenuItem___Famil__26C59E94");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.MenuItemFamilyDinnerItem)
                    .HasForeignKey(d => d.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MenuItem___MenuI__25D17A5B");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.ToTable("Order", "Sales");

                entity.Property(e => e.SubTotal)
                    .HasColumnType("money")
                    .HasComputedColumnSql("([Sales].[OrderSubTotal]([OrderId]))");

                entity.Property(e => e.Tip)
                    .HasColumnType("money")
                    .HasDefaultValueSql("((0))");

                entity.HasOne(d => d.Account)
                    .WithMany(p => p.Order)
                    .HasForeignKey(d => d.AccountId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Order__AccountId__3BC0BB7A");
            });

            modelBuilder.Entity<OrderItem>(entity =>
            {
                entity.ToTable("OrderItem", "Sales");

                entity.Property(e => e.Quantity).HasDefaultValueSql("((1))");

                entity.Property(e => e.SubTotal)
                    .HasColumnType("money")
                    .HasComputedColumnSql("([Sales].[OrderItemSubTotal]([MenuItemId],[Quantity]))");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.OrderItem)
                    .HasForeignKey(d => d.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrderItem__MenuI__40857097");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.OrderItem)
                    .HasForeignKey(d => d.OrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrderItem__Order__417994D0");
            });

            modelBuilder.Entity<SpicyOption>(entity =>
            {
                entity.ToTable("SpicyOption", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__SpicyOpt__EDBE0C58FAB7CF84")
                    .IsUnique();

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });
        }
    }
}
