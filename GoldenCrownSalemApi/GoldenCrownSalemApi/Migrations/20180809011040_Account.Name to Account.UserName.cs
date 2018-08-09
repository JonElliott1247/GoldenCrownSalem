using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Migrations
{
    public partial class AccountNametoAccountUserName : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "Sales");

            migrationBuilder.EnsureSchema(
                name: "Menu");

            migrationBuilder.CreateTable(
                name: "Category",
                schema: "Menu",
                columns: table => new
                {
                    CategoryId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Description = table.Column<string>(unicode: false, maxLength: 100, nullable: true),
                    Label = table.Column<string>(unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Category", x => x.CategoryId);
                });

            migrationBuilder.CreateTable(
                name: "SpicyOption",
                schema: "Menu",
                columns: table => new
                {
                    SpicyOptionId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Label = table.Column<string>(unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SpicyOption", x => x.SpicyOptionId);
                });

            migrationBuilder.CreateTable(
                name: "Account",
                schema: "Sales",
                columns: table => new
                {
                    AccountId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Hash = table.Column<byte[]>(type: "binary(36)", nullable: true),
                    Salt = table.Column<byte[]>(type: "binary(16)", nullable: true),
                    UserName = table.Column<string>(unicode: false, maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Account", x => x.AccountId);
                });

            migrationBuilder.CreateTable(
                name: "CombinationPlateItem",
                schema: "Menu",
                columns: table => new
                {
                    CombinationPlateItemId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    DefaultSpicyOptionId = table.Column<int>(nullable: true),
                    Label = table.Column<string>(unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CombinationPlateItem", x => x.CombinationPlateItemId);
                    table.ForeignKey(
                        name: "FK__Combinati__Defau__2D729C23",
                        column: x => x.DefaultSpicyOptionId,
                        principalSchema: "Menu",
                        principalTable: "SpicyOption",
                        principalColumn: "SpicyOptionId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "FamilyDinnerItem",
                schema: "Menu",
                columns: table => new
                {
                    FamilyDinnerItemId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    DefaultSpicyOptionId = table.Column<int>(nullable: false),
                    Label = table.Column<string>(unicode: false, maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FamilyDinnerItem", x => x.FamilyDinnerItemId);
                    table.ForeignKey(
                        name: "FK__FamilyDin__Defau__22F50DB0",
                        column: x => x.DefaultSpicyOptionId,
                        principalSchema: "Menu",
                        principalTable: "SpicyOption",
                        principalColumn: "SpicyOptionId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "MenuItem",
                schema: "Menu",
                columns: table => new
                {
                    MenuItemId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    CategoryId = table.Column<int>(nullable: false),
                    DefaultSpicyOptionId = table.Column<int>(nullable: true),
                    Description = table.Column<string>(unicode: false, maxLength: 100, nullable: true),
                    IsAvailable = table.Column<bool>(nullable: false),
                    Label = table.Column<string>(unicode: false, maxLength: 100, nullable: false),
                    Price = table.Column<decimal>(type: "money", nullable: false),
                    SubLabel = table.Column<string>(unicode: false, maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MenuItem", x => x.MenuItemId);
                    table.ForeignKey(
                        name: "FK__MenuItem__Catego__1D3C345A",
                        column: x => x.CategoryId,
                        principalSchema: "Menu",
                        principalTable: "Category",
                        principalColumn: "CategoryId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK__MenuItem__Defaul__1E305893",
                        column: x => x.DefaultSpicyOptionId,
                        principalSchema: "Menu",
                        principalTable: "SpicyOption",
                        principalColumn: "SpicyOptionId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Order",
                schema: "Sales",
                columns: table => new
                {
                    OrderId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    AccountId = table.Column<int>(nullable: false),
                    SubTotal = table.Column<decimal>(type: "money", nullable: true, computedColumnSql: "([Sales].[OrderSubTotal]([OrderId]))"),
                    Tip = table.Column<decimal>(type: "money", nullable: false, defaultValueSql: "((0))")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Order", x => x.OrderId);
                    table.ForeignKey(
                        name: "FK__Order__AccountId__3BC0BB7A",
                        column: x => x.AccountId,
                        principalSchema: "Sales",
                        principalTable: "Account",
                        principalColumn: "AccountId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "MenuItem_CombinationPlateItem",
                schema: "Menu",
                columns: table => new
                {
                    MenuItemFamilyDinnerItemId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    CombinationPlateItemId = table.Column<int>(nullable: true),
                    MenuItemId = table.Column<int>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MenuItem_CombinationPlateItem", x => x.MenuItemFamilyDinnerItemId);
                    table.ForeignKey(
                        name: "FK__MenuItem___Combi__31432D07",
                        column: x => x.CombinationPlateItemId,
                        principalSchema: "Menu",
                        principalTable: "CombinationPlateItem",
                        principalColumn: "CombinationPlateItemId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK__MenuItem___MenuI__304F08CE",
                        column: x => x.MenuItemId,
                        principalSchema: "Menu",
                        principalTable: "MenuItem",
                        principalColumn: "MenuItemId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "MenuItem_FamilyDinnerItem",
                schema: "Menu",
                columns: table => new
                {
                    MenuItemFamilyDinnerItemId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    FamilyDinnerItemId = table.Column<int>(nullable: false),
                    IsAppetizer = table.Column<bool>(nullable: false),
                    IsEntree = table.Column<bool>(nullable: false),
                    IsSpecial = table.Column<bool>(nullable: false),
                    MenuItemId = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MenuItem_FamilyDinnerItem", x => x.MenuItemFamilyDinnerItemId);
                    table.ForeignKey(
                        name: "FK__MenuItem___Famil__26C59E94",
                        column: x => x.FamilyDinnerItemId,
                        principalSchema: "Menu",
                        principalTable: "FamilyDinnerItem",
                        principalColumn: "FamilyDinnerItemId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK__MenuItem___MenuI__25D17A5B",
                        column: x => x.MenuItemId,
                        principalSchema: "Menu",
                        principalTable: "MenuItem",
                        principalColumn: "MenuItemId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "OrderItem",
                schema: "Sales",
                columns: table => new
                {
                    OrderItemId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    MenuItemId = table.Column<int>(nullable: false),
                    OrderId = table.Column<int>(nullable: false),
                    Quantity = table.Column<int>(nullable: false, defaultValueSql: "((1))"),
                    SubTotal = table.Column<decimal>(type: "money", nullable: true, computedColumnSql: "([Sales].[OrderItemSubTotal]([MenuItemId],[Quantity]))")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderItem", x => x.OrderItemId);
                    table.ForeignKey(
                        name: "FK__OrderItem__MenuI__40857097",
                        column: x => x.MenuItemId,
                        principalSchema: "Menu",
                        principalTable: "MenuItem",
                        principalColumn: "MenuItemId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK__OrderItem__Order__417994D0",
                        column: x => x.OrderId,
                        principalSchema: "Sales",
                        principalTable: "Order",
                        principalColumn: "OrderId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "UQ__Category__EDBE0C58103C311F",
                schema: "Menu",
                table: "Category",
                column: "Label",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CombinationPlateItem_DefaultSpicyOptionId",
                schema: "Menu",
                table: "CombinationPlateItem",
                column: "DefaultSpicyOptionId");

            migrationBuilder.CreateIndex(
                name: "UQ__Combinat__EDBE0C587C4DAC49",
                schema: "Menu",
                table: "CombinationPlateItem",
                column: "Label",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_FamilyDinnerItem_DefaultSpicyOptionId",
                schema: "Menu",
                table: "FamilyDinnerItem",
                column: "DefaultSpicyOptionId");

            migrationBuilder.CreateIndex(
                name: "UQ__FamilyDi__EDBE0C58F648D4C2",
                schema: "Menu",
                table: "FamilyDinnerItem",
                column: "Label",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_MenuItem_CategoryId",
                schema: "Menu",
                table: "MenuItem",
                column: "CategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_MenuItem_DefaultSpicyOptionId",
                schema: "Menu",
                table: "MenuItem",
                column: "DefaultSpicyOptionId");

            migrationBuilder.CreateIndex(
                name: "UniqueLabelIndex",
                schema: "Menu",
                table: "MenuItem",
                column: "Label",
                unique: true,
                filter: "([SubLabel] IS NULL)");

            migrationBuilder.CreateIndex(
                name: "UniqueLabelSubLabelIndex",
                schema: "Menu",
                table: "MenuItem",
                columns: new[] { "Label", "SubLabel" },
                unique: true,
                filter: "[Label] IS NOT NULL AND [SubLabel] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_MenuItem_CombinationPlateItem_CombinationPlateItemId",
                schema: "Menu",
                table: "MenuItem_CombinationPlateItem",
                column: "CombinationPlateItemId");

            migrationBuilder.CreateIndex(
                name: "IX_MenuItem_CombinationPlateItem_MenuItemId",
                schema: "Menu",
                table: "MenuItem_CombinationPlateItem",
                column: "MenuItemId");

            migrationBuilder.CreateIndex(
                name: "IX_MenuItem_FamilyDinnerItem_FamilyDinnerItemId",
                schema: "Menu",
                table: "MenuItem_FamilyDinnerItem",
                column: "FamilyDinnerItemId");

            migrationBuilder.CreateIndex(
                name: "IX_MenuItem_FamilyDinnerItem_MenuItemId",
                schema: "Menu",
                table: "MenuItem_FamilyDinnerItem",
                column: "MenuItemId");

            migrationBuilder.CreateIndex(
                name: "UQ__SpicyOpt__EDBE0C58FAB7CF84",
                schema: "Menu",
                table: "SpicyOption",
                column: "Label",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Order_AccountId",
                schema: "Sales",
                table: "Order",
                column: "AccountId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderItem_MenuItemId",
                schema: "Sales",
                table: "OrderItem",
                column: "MenuItemId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderItem_OrderId",
                schema: "Sales",
                table: "OrderItem",
                column: "OrderId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MenuItem_CombinationPlateItem",
                schema: "Menu");

            migrationBuilder.DropTable(
                name: "MenuItem_FamilyDinnerItem",
                schema: "Menu");

            migrationBuilder.DropTable(
                name: "OrderItem",
                schema: "Sales");

            migrationBuilder.DropTable(
                name: "CombinationPlateItem",
                schema: "Menu");

            migrationBuilder.DropTable(
                name: "FamilyDinnerItem",
                schema: "Menu");

            migrationBuilder.DropTable(
                name: "MenuItem",
                schema: "Menu");

            migrationBuilder.DropTable(
                name: "Order",
                schema: "Sales");

            migrationBuilder.DropTable(
                name: "Category",
                schema: "Menu");

            migrationBuilder.DropTable(
                name: "SpicyOption",
                schema: "Menu");

            migrationBuilder.DropTable(
                name: "Account",
                schema: "Sales");
        }
    }
}
