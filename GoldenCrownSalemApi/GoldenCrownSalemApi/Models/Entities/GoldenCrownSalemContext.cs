using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace GoldenCrownSalemApi.Models.Entities
{
    public partial class GoldenCrownSalemContext : DbContext
    {
        public GoldenCrownSalemContext()
        {
        }

        public GoldenCrownSalemContext(DbContextOptions<GoldenCrownSalemContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Account> Accounts { get; set; }
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<CombinationPlateItem> CombinationPlateItems { get; set; }
        public virtual DbSet<FamilyDinnerItem> FamilyDinnerItems { get; set; }
        public virtual DbSet<MenuItem> MenuItems { get; set; }
        public virtual DbSet<MenuItemCombinationPlateItem> MenuItemCombinationPlateItems { get; set; }
        public virtual DbSet<MenuItemFamilyDinnerItem> MenuItemFamilyDinnerItems { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderItem> OrderItems { get; set; }
        public virtual DbSet<SpicyOption> SpicyOptions { get; set; }

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

                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__Account__C9F28456F67BD590")
                    .IsUnique();

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Hash)
                    .IsRequired()
                    .HasColumnType("binary(64)");

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Salt)
                    .IsRequired()
                    .HasColumnType("binary(128)");

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__Category__EDBE0C58A2E3A03A")
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
                    .HasName("UQ__Combinat__EDBE0C58595D5D83")
                    .IsUnique();

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.HasOne(d => d.DefaultSpicyOption)
                    .WithMany(p => p.CombinationPlateItems)
                    .HasForeignKey(d => d.DefaultSpicyOptionId)
                    .HasConstraintName("FK__Combinati__Defau__78159CA3");
            });

            modelBuilder.Entity<FamilyDinnerItem>(entity =>
            {
                entity.ToTable("FamilyDinnerItem", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__FamilyDi__EDBE0C5819AE8DE1")
                    .IsUnique();

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.HasOne(d => d.DefaultSpicyOption)
                    .WithMany(p => p.FamilyDinnerItems)
                    .HasForeignKey(d => d.DefaultSpicyOptionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__FamilyDin__Defau__6D980E30");
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
                    .WithMany(p => p.MenuItems)
                    .HasForeignKey(d => d.CategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MenuItem__Catego__67DF34DA");

                entity.HasOne(d => d.DefaultSpicyOption)
                    .WithMany(p => p.MenuItems)
                    .HasForeignKey(d => d.DefaultSpicyOptionId)
                    .HasConstraintName("FK__MenuItem__Defaul__68D35913");
            });

            modelBuilder.Entity<MenuItemCombinationPlateItem>(entity =>
            {
                entity.HasKey(e => e.MenuItemFamilyDinnerItemId);

                entity.ToTable("MenuItem_CombinationPlateItem", "Menu");

                entity.HasOne(d => d.CombinationPlateItem)
                    .WithMany(p => p.MenuItemCombinationPlateItems)
                    .HasForeignKey(d => d.CombinationPlateItemId)
                    .HasConstraintName("FK__MenuItem___Combi__7BE62D87");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.MenuItemCombinationPlateItems)
                    .HasForeignKey(d => d.MenuItemId)
                    .HasConstraintName("FK__MenuItem___MenuI__7AF2094E");
            });

            modelBuilder.Entity<MenuItemFamilyDinnerItem>(entity =>
            {
                entity.ToTable("MenuItem_FamilyDinnerItem", "Menu");

                entity.HasOne(d => d.FamilyDinnerItem)
                    .WithMany(p => p.MenuItemFamilyDinnerItems)
                    .HasForeignKey(d => d.FamilyDinnerItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MenuItem___Famil__71689F14");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.MenuItemFamilyDinnerItems)
                    .HasForeignKey(d => d.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__MenuItem___MenuI__70747ADB");
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
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.AccountId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Order__AccountId__0757E033");
            });

            modelBuilder.Entity<OrderItem>(entity =>
            {
                entity.ToTable("OrderItem", "Sales");

                entity.Property(e => e.Quantity).HasDefaultValueSql("((1))");

                entity.Property(e => e.SubTotal)
                    .HasColumnType("money")
                    .HasComputedColumnSql("([Sales].[OrderItemSubTotal]([MenuItemId],[Quantity]))");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.OrderItems)
                    .HasForeignKey(d => d.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrderItem__MenuI__0C1C9550");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.OrderItems)
                    .HasForeignKey(d => d.OrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrderItem__Order__0D10B989");
            });

            modelBuilder.Entity<SpicyOption>(entity =>
            {
                entity.ToTable("SpicyOption", "Menu");

                entity.HasIndex(e => e.Label)
                    .HasName("UQ__SpicyOpt__EDBE0C58E413DEDD")
                    .IsUnique();

                entity.Property(e => e.Label)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });
        }
    }
}
