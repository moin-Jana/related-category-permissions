import Component from "@glimmer/component";
import Category from "discourse/models/category";
import i18n from "discourse-common/helpers/i18n";
import eq from "truth-helpers/helpers/eq";
import themePrefix from "discourse/helpers/theme-prefix"; // 👈 ADD THIS
import ExpandableItem from "../components/expandable-item"; // 👈 Renamed for cleaner template

export default class ExpandablePermissionsComponent extends Component {
  getSlugPath = (category) => Category.slugFor(category);

  <template>
    <section class="related-category-security">
      {{#if (eq @category.level 2)}}
        <div class="related-grandparent-category">
          <h4>{{i18n (themePrefix "grandparent_category")}}</h4>
          <ExpandableItem
            @label={{@category.parentCategory.parentCategory.name}}
            @slugPath={{this.getSlugPath
              @category.parentCategory.parentCategory
            }}
            @catID={{@category.parentCategory.parentCategory.id}}
          />
        </div>
      {{/if}}

      {{#if @category.level}}
        <div class="related-parent-category">
          <h4>{{i18n (themePrefix "parent_category")}}</h4>
          <ExpandableItem
            @label={{@category.parentCategory.name}}
            @slugPath={{this.getSlugPath @category.parentCategory}}
            @catID={{@category.parentCategory.id}}
          />
        </div>
      {{/if}}

      {{#if @category.subcategories}}
        <div class="related-subcategories">
          <h4>{{i18n (themePrefix "subcategories")}}</h4>
          <div class="related-subcategory-list">
            {{#each @category.subcategories as |subcategory|}}
              <ExpandableItem
                @label={{subcategory.name}}
                @slugPath={{this.getSlugPath subcategory}}
                @catID={{subcategory.id}}
                @checkSubSub={{eq subcategory.level 1}}
              />
            {{/each}}
          </div>
        </div>
      {{/if}}
    </section>
  </template>
}
